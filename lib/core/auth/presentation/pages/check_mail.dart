import '../widgets/widgets.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FlavorBanner(
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Check your email'.capitalize!,
            style: textTheme.titleLarge,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mail_outline, size: 64, color: Colors.blue),
                    const SizedBox(height: 24),
                    Text(
                      'Check your email'.capitalize!,
                      style: textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We\'ve sent a password reset link to your email address. Please check your inbox and follow the instructions to continue!',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.offAllNamed(Routers.login),
                        child: Text(
                          'Return to Login',
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
