import 'package:flutter/material.dart';
import 'package:plato_calendar/model/model.dart';
import 'package:plato_calendar/service/service.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // 애니메이션 컨트롤러
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false; // 로딩 중인지 표시
  String? _errorMessage; // 로그인 실패 시 메시지 저장

  @override
  void initState() {
    super.initState();

    // 다이얼로그가 등장할 때 살짝 커지는 애니메이션
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutBack);

    // 애니메이션 시작
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  /// 실제 로그인 로직
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // 에러 메시지 초기화
    });

    final username = _idController.text;
    final password = _pwController.text;

    try {
      final credentialInfo = PlatoCredential()
        ..username = username
        ..password = password;

      // id, pw가 일치하는지 확인
      bool loginResult = await CalendarAPI.checkPlatoLogin(credentialInfo);

      if (loginResult) {
        // 로그인 성공. 다이얼로그 닫고 credentialInfo 반환
        final credentialInfo = PlatoCredential()
          ..username = username
          ..password = password;

        if (!mounted) {
          return;
        } else {
          Navigator.of(context).pop(credentialInfo);
        }
      } else {
        // 로그인 실패 시
        setState(() {
          _errorMessage = 'ID 또는 비밀번호가 일치하지 않습니다.';
          _isLoading = false;
        });
      }
    } catch (e) {
      // 로그인 실패 시 에러 메시지 처리
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      // 로딩 상태 해제
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        // backgroundColor : colorScheme.onInverseSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // 배경에 그라디언트를 주려면 Container로 감싸서 decoration을 줄 수도 있음
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 헤더 아이콘/텍스트 등
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline,
                        size: 40, color: colorScheme.primary),
                    SizedBox(width: 8),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ID 입력
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),

                // PW 입력
                TextField(
                  controller: _pwController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),

                // 에러 메시지가 있으면 표시
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: colorScheme.error),
                  ),
                ],

                const SizedBox(height: 16),
                // 로딩중이면 로딩 인디케이터, 아니면 로그인 버튼
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: _login,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Login'),
                      ),
                const SizedBox(height: 8),

                // 취소 버튼
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
