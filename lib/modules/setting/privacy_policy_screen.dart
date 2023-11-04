import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/constants.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controllers/privacy_and_term_condition_cubit/privacy_and_term_condition_cubit.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PrivacyAndTermConditionCubit>().getTermsAndConditionData();
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Privacy Policy'),
      body: BlocBuilder<PrivacyAndTermConditionCubit,
          PrivacyTermConditionCubitState>(
        builder: (context, state) {
          if (state is TermConditionCubitStateLoaded) {
            final termsAndCondition = state.privacyPolicyAndTermConditionModel;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: policy(),
            );
          } else if (state is TermConditionCubitStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TermConditionCubitStateError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
  SingleChildScrollView policy() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            'This Privacy Policy is designed to help you understand how we collect, use, disclose, and safeguard your personal information in accordance of the Protection of Personal Information Act 4 of 2013 (“POPI”). By using our Website (www.bulkhub.co.za, related mobile sites and software applications, hereinafter referred to as the “Website”) or Services, you consent to the practices described in this Privacy Policy.\n',
          ),
          Text(
            'Information We Collect\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'We may collect personal information such as your name, contact information (email address, phone number, address), payment information, as well as billing and shipping details. Additionally, we may collect non-personal information, which does not directly identify you. This may include browser information, device type, and usage data.\n',
          ),
          Text(
            'How We Use Your Information\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'We use the collected information for various purposes, including but not limited to processing and fulfilling orders, providing customer support, sending transactional emails, improving our Services and Website, marketing and promotional purposes (with your consent), and complying with legal obligations.\n',
          ),
          Text(
            'Information Sharing and Disclosure\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'We do not sell, trade, or rent your personal information to third parties. However, we may share your information with service providers and partners who assist with our operations, legal and regulatory authorities in compliance with applicable laws, and in the event of a merger, acquisition, or sale of assets.\n',
          ),
          Text(
            'Cookies and Tracking Technologies\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'To enhance your browsing experience and collect usage data, we use cookies and similar technologies. You can manage cookie preferences through your browser settings.\n',
          ),
          Text(
            'Your Rights\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'You have the right to access, correct, or delete your personal information. You can also opt-out of marketing communications, withdraw consent for processing (where applicable), and lodge a complaint with a supervisory authority.\n',
          ),
          Text(
            'Data Security\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'We implement reasonable security measures to protect your personal information. However, it’s important to note that no method of transmission over the internet or electronic storage is completely secure.\n',
          ),
          Text(
            'Changes to this Privacy Policy\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'We may update this Privacy Policy from time to time. The updated version will be effective upon posting.\n',
          ),
          Text(
            'Contact Us\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'If you have any questions or concerns about this Privacy Policy, please contact us at helpdesk@bulkhub.co.za.',
          ),
          SizedBox(height: 20.0),
          Text(
            'Seller Agreement',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Our Terms And Conditions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Sale Agreement\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'This Sale Agreement (the “Agreement”) is entered into by and between Bulkhub, a company registered in accordance with the Companies Act 71 of 2008, hereinafter referred to as “Bulkhub”, and the individual or entity registering as a seller on the Platform, hereinafter referred to as the “Seller.”',
          ),
          Text(
            'By registering as a seller on www.bulkhub.co.za and related mobile sites and software applications, hereinafter referred to as the “Platform”, the Seller agrees to be bound by the terms and conditions set forth in this Agreement.\n',
          ),
          Text(
            'REGISTRATION AND ACCOUNT\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '1.1 Eligibility: The Seller must be a legal entity or an individual of legal age in their jurisdiction to enter into this Agreement.',
          ),
          Text(
            '1.2 Registration: The Seller shall provide accurate and complete information during the registration process. Bulkhub reserves the right to verify the provided information.',
          ),
          Text(
            '1.3 Account Security: The Seller is responsible for maintaining the confidentiality of their account and password. Any activity that occurs under the Seller’s account is their sole responsibility.\n',
          ),
          Text(
            'PRODUCT LISTING AND SALES\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '2.1 Product Listing: The Seller agrees to accurately and adequately list their products on Bulkhub, including detailed descriptions, pricing, and availability.',
          ),
          Text(
            '2.2 Pricing: The Seller has the discretion to set their own prices. The Platform may, in some cases, provide pricing recommendations.',
          ),
          Text(
            '2.3 Order Fulfilment: The Seller agrees to promptly fulfil orders placed by customers through Bulkhub, in accordance with the agreed-upon processing times.',
          ),
          Text(
            '2.4 Product Quality: The Seller assures that all products listed meet the quality standards set forth by Bulkhub and comply with applicable laws and regulations.\n',
          ),
          Text(
            'COMMISSION AND PAYMENTS\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '3.1 Commission Fees: Bulkhub may charge the Seller a commission fee for each successful sale. The applicable commission rates will be communicated to the Seller.',
          ),
          Text(
            '3.2 Payments: Bulkhub will remit payments to the Seller, minus applicable commission fees, within 3 business days of successful order completion.',
          ),
          Text(
            '3.3 Tax Responsibility: The Seller is solely responsible for any taxes or duties associated with their sales on Bulkhub.\n',
          ),
          Text(
            'INTELLECTUAL PROPERTY\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '4.1 Ownership: The Seller retains all rights, titles, and interests in and to their intellectual property.',
          ),
          Text(
            '4.2 Licence: The Seller grants Bulkhub a non-exclusive, worldwide, royalty-free licence to use, display, and reproduce the Seller’s intellectual property solely for the purpose of operating on Bulkhub.\n',
          ),
          Text(
            'TERMINATION\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '5.1 Termination by Seller: The Seller may terminate this Agreement at any time by providing written notice to Bulkhub.',
          ),
          Text(
            '5.2 Termination by Platform: Bulkhub may, at its sole discretion, terminate this Agreement with or without cause, with notice to the Seller.\n',
          ),
          Text(
            'MISCELLANEOUS\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '6.1 Governing Law: This Agreement shall be governed by and construed in accordance with the laws of South Africa.',
          ),
          Text(
            '6.2 Entire Agreement: This Agreement constitutes the entire agreement between the parties and supersedes all prior and contemporaneous agreements, understandings, and negotiations.',
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Terms & Conditions'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: TextContent(),
//         ),
//       ),
//     );
//   }
// }


