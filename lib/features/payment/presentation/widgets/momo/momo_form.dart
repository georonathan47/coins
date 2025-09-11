import '../widgets.dart';

class MomoForm extends StatelessWidget {
  const MomoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return GetBuilder<PayAccountsController>(
      builder: (instance) {
        return Form(
          child: ScrollableWidget(
            padding: 4,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name On Account',
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Account Type',
                  border: OutlineInputBorder(),
                ),
                items: instance.momoAccountTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type.toUpperCase(),
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {},
                // value: instance.selectedAccountType,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Network Operator',
                  border: OutlineInputBorder(),
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
