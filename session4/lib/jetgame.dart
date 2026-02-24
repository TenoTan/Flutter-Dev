// FULL SPACE JET SHOOTER GAME WITH START SCREEN, FADE TRANSITION, KEYBOARD + DRAG CONTROLS
// FIXED VERSION:
// - Jet correctly fixed at bottom
// - Drag moves jet only horizontally
// - Space bar shoots lasers
// - Meteoroids fall from top
// - Collision with jet tracked
// - If >5 hits → GAME OVER screen
// - Proper alignment + bug fixes

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SpaceJetGame());
}

class SpaceJetGame extends StatelessWidget {
  const SpaceJetGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}

// ================= START SCREEN =================
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  void startGame() async {
    await _fadeController.forward();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const GameScreen(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.deepPurple, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch, size: 120, color: Colors.cyanAccent),
                const SizedBox(height: 20),
                const Text(
                  'SPACE JET SHOOTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: const Text('START GAME', style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= GAME SCREEN =================
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _gameLoop;

  double jetX = 0.0; // -1 to 1
  int score = 0;
  int hits = 0;
  bool gameOver = false;

  final Random random = Random();
  List<Laser> lasers = [];
  List<Meteor> meteors = [];

  @override
  void initState() {
    super.initState();

    _gameLoop = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..addListener(updateGame);

    _gameLoop.forward();

    // spawn meteors
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!gameOver) {
        meteors.add(Meteor(x: random.nextDouble() * 2 - 1, y: -1.2));
      }
    });

    // keyboard shooting
    RawKeyboard.instance.addListener((RawKeyEvent event) {
      if (!gameOver && event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
        shoot();
      }
    });
  }

  void shoot() {
    lasers.add(Laser(x: jetX, y: 0.85)); // from jet nose
  }

  void updateGame() {
    if (gameOver) return;

    setState(() {
      // move lasers
      for (var l in lasers) {
        l.y -= 0.05;
      }
      lasers.removeWhere((l) => l.y < -1.2);

      // move meteors
      for (var m in meteors) {
        m.y += 0.018;
      }

      // collision: laser vs meteor
      lasers.removeWhere((l) {
        for (var m in meteors) {
          if ((l.x - m.x).abs() < 0.08 && (l.y - m.y).abs() < 0.08) {
            meteors.remove(m);
            score++;
            return true;
          }
        }
        return false;
      });

      // collision: meteor vs jet
      meteors.removeWhere((m) {
        if ((m.x - jetX).abs() < 0.12 && (m.y - 0.9).abs() < 0.12) {
          hits++;
          if (hits > 5) {
            gameOver = true;
          }
          return true;
        }
        return false;
      });
    });
  }

  @override
  void dispose() {
    _gameLoop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (d) {
          if (!gameOver) {
            setState(() {
              jetX += d.delta.dx / 300;
              jetX = jetX.clamp(-1.0, 1.0);
            });
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.black, Colors.indigo, Colors.black],
              radius: 1.2,
            ),
          ),
          child: Stack(
            children: [
              // stars background
              ...List.generate(80, (i) {
                final x = random.nextDouble() * 2 - 1;
                final y = random.nextDouble() * 2 - 1;
                return Align(
                  alignment: Alignment(x, y),
                  child: Container(width: 2, height: 2, color: Colors.white24),
                );
              }),

              // score + hits
              Positioned(
                top: 40,
                left: 20,
                child: Text('Score: $score  |  Hits: $hits/5', style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),

              // jet (FIXED AT BOTTOM)
              Align(
                alignment: Alignment(jetX, 0.95),
                child: Column(
                  children: const [
                    Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 18),
                    Icon(Icons.airplanemode_active, color: Colors.cyanAccent, size: 60),
                  ],
                ),
              ),

              // lasers
              ...lasers.map((l) => Align(
                alignment: Alignment(l.x, l.y),
                child: Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
                    boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.8), blurRadius: 10)],
                  ),
                ),
              )),

              // meteors
              ...meteors.map((m) => Align(
                alignment: Alignment(m.x, m.y),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(colors: [Colors.brown, Colors.redAccent]),
                    boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.8), blurRadius: 15, spreadRadius: 5)],
                  ),
                ),
              )),

              // GAME OVER OVERLAY
              if (gameOver)
                Container(
                  color: Colors.black.withOpacity(0.85),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('GAME OVER', style: TextStyle(color: Colors.redAccent, fontSize: 42, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Text('Better luck next time!', style: TextStyle(color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const StartScreen()),
                            );
                          },
                          child: const Text('RESTART'),
                        )
                      ],
                    ),
                  ),
                ),

              // controls hint
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: const Center(
                  child: Text('Drag to move  |  Space to shoot', style: TextStyle(color: Colors.white54)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MODELS =================
class Laser {
  double x;
  double y;
  Laser({required this.x, required this.y});
}

class Meteor {
  double x;
  double y;
  Meteor({required this.x, required this.y});
}
