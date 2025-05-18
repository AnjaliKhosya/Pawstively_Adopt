import 'package:flutter/material.dart';
class privacy extends StatelessWidget {
  const privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 18.0,right: 8.0),
            child: ListView(
              children: [
                Text('Privacy Policy :',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'gabarito',
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0,bottom: 30.0),
                  child: Text('This privacy policy sets out how PET ADOPTION APPLICATION uses and protects any information you give us when you use this application. We are committed to making sure that your privacy is protected. Should we ask you to provide certain information by which you can be identified when using this application, you can be assured that it will only be used according to this privacy statement. We may change this policy from time to time by updating this page,'
                      ,style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text('Please read this policy carefully to understand our policies and practices regarding your information and how we will treat it. If you do not agree with our policies and practices, your choice is not to use our Website. By accessing or using this Website, you agree to this privacy policy. This policy may change from time to time (see Changes to Our Privacy Policy). Your continued use of this Website after we make changes is deemed to be acceptance of those changes, so please check the policy periodically for updates',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding:  const EdgeInsets.only(bottom: 15.0),
                  child: Text('Children Under the Age of 13',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text('Our Website is not intended for children under 13 years of age. No one under age 13 may provide any personal information on the app. We do not knowingly collect personal information from children under 13. If you are under 13, do not provide any information on this app or on or through any of its features/register on the app, use any of the interactive or public comment features of this app or provide any information about yourself to us, including your name, address, telephone number, email address, or any screen name or user name you may use. If we learn we have collected or received personal information from a child under 13 without verification of parental consent, we will delete that information. If you believe we might have any information from or about a child under 13, please contact us at the contact information below',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ), ),
                ),
                Text('What Information PET ADOPTION APPLICATION collects',
                  style: TextStyle(
                    fontFamily: 'gabarito',
                    fontSize: 20,
                    color: Colors.black,
                  ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('We may collect the following information:',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Your name',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Your contact information, including email address',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Your demographic information, such as',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('   postcode, preferences, and interest',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('We collect this information',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Directly from you when you provide it to us.',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Information collected automatically may include usage details, IP addresses, and information collected through cookies, web beacons, and other tracking technologies.',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Information You Provide to Us',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Information that you provide by filling in forms, submitting donations or requests or completing applications, on our Website. We may also ask you for information when you report a problem with our Website',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• Records and copies of your correspondence (including email addresses), if you contact us',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('You also may provide information to be published or displayed (hereinafter, "posted") on public areas of the Website or transmitted to other users of the Website or third parties (collectively, "User Contributions"). Your User Contributions are posted on and transmitted to others at your own risk. Although, please be aware that no security measures are perfect or impenetrable. Additionally, we cannot control the actions of other users of the Website with whom you may choose to share your User Contributions. Therefore, we cannot and do not guarantee that your User Contributions will not be viewed by unauthorized persons.',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('How We Use Your Information',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('We use information that we collect about you or that you provide to us, including any personal information:',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• To present our app and its contents to you',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• To provide you with information or services that you request from us',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• To fulfill any other purpose for which you provide it',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• To notify you about changes to our Website or any events, information or services we offer or provide though it',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• In any other way we may describe when you provide the information',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('• For any other purpose with your consent',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Disclosure of Your Information',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('• To comply with any court order, law, or legal process, including to respond to any government or regulatory request.',
                      style: TextStyle(
                        fontFamily: 'gabarito',
                        fontSize: 15,
                        color: Colors.black54,
                      ),),
                  ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('• If we believe disclosure is necessary or appropriate to protect the rights, property, or safety of Animal Rescue Project, our members, or others',
                style: TextStyle(
                  fontFamily: 'gabarito',
                  fontSize: 15,
                  color: Colors.black54,
                ),),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Contact Information',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('To ask questions or comment about this privacy policy and our privacy practices, contact us at:',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Pet Adoption project :',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Anjali',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('or by email at: anjaliydvoffical@gmail.com',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15,
                      color: Colors.black54,
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
