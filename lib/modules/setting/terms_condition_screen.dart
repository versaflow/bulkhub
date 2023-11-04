import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/constants.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controllers/privacy_and_term_condition_cubit/privacy_and_term_condition_cubit.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PrivacyAndTermConditionCubit>().getTermsAndConditionData();
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Terms & Condition'),
      body: BlocBuilder<PrivacyAndTermConditionCubit,
          PrivacyTermConditionCubitState>(
        builder: (context, state) {
          if (state is TermConditionCubitStateLoaded) {
            final termsAndCondition = state.privacyPolicyAndTermConditionModel;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: TextContent(),
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
}

class TextContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        Text(
          'These terms and conditions (the “Terms & Conditions”) establish the agreement on which BulkHub PTY Ltd., trading as BulkHub and/or its affiliates (referred to as “we,” “us,” or “BulkHub”) provide access to this website at the domain names www.bulkhub.co.za, including mobile websites, and associated services (collectively referred to as the “Websites”) to you, along with any other services accessible through the www.bulkhub.co.za website. These terms and conditions regulate the usage of the Website and/or services provided by BulkHub.',
        ),
        Text(
          'By visiting the website and/or making a purchase, you engage in our “Service” and accept to be bound by the following terms and conditions (“Terms & Conditions,” “Terms of Service,” “Terms”), which include any additional terms, conditions, and policies referenced herein and/or available via hyperlink. These Terms are applicable to all users of the website, encompassing, but not limited to, browsers, vendors, customers, merchants, and content distributors.',
        ),
        Text(
          'We urge you to carefully read these Terms before accessing or using our Website. By accessing any part of the website, you signify your agreement to comply with these Terms. If you do not concur with all the terms and conditions of this agreement, you are not authorized to access the website or utilize any of our services. If these Terms are construed as an offer, acceptance is expressly limited to these Terms.',
        ),
        Text(
          'Any new features or tools introduced to the current store will also be subject to these Terms. You can review the most recent version of the Terms at any time on this page. We retain the right to update, modify, or replace any portion of these Terms by posting updates and/or alterations to our Website. It is your responsibility to periodically check this page for changes. Your continued use of or access to the Website following the posting of any changes constitutes acceptance of those changes.',
        ),
        Text(
          'The headings used in this agreement are for convenience only and do not limit or otherwise affect these Terms.\n',
        ),

        Text(
          'Terms & Conditions for Bulkhub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'SECTION 1 - ONLINE STORE TERMS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'By accepting these Terms, you affirm that you are of the legal age of majority in your state or province of residence, and that you grant us permission to allow any minor dependents under your care to use this website.',
        ),
        Text(
          'You are prohibited from using our products for any unlawful or unauthorized purpose, and must not violate any laws in your jurisdiction, including copyright laws, while using our Service. A breach of any of these Terms may lead to the termination of our Services.\n',
        ),
        Text(
          'SECTION 2 - GENERAL CONDITIONS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'We hold the right to decline service to any individual for any reason, at any given time.',
        ),
        Text(
          'You acknowledge that your content, excluding credit card information, may be transmitted unencrypted and may involve transmissions over various networks and alterations to conform and adapt to the technical requirements of different networks or devices. Credit card information is always encrypted during transfer over networks.',
        ),
        Text(
          'You agree not to reproduce, duplicate, copy, sell, resell, or exploit any aspect of our Service, including the use of the Service, or access to the Service, or any contact on the website through which the service is provided, without explicit permission from us.\n',
        ),
        Text(
          'SECTION 3 - ACCURACY OF INFORMATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'We do not accept responsibility if the information provided on this website is not accurate, complete, or up to date. The content on this website is provided for general information only and should not be solely relied upon for decision-making. For crucial decisions, consult more accurate, complete, or timely sources of information. This website may contain certain historical information, which is not current and is provided for your reference only. We reserve the right to modify the contents of this website at any time, but we have no obligation to update any information on our website. Monitoring changes to our website is your responsibility.\n',
        ),
        Text(
          'SECTION 4 - ACCURACY OF BILLING AND ACCOUNT INFORMATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'We hold the right to refuse any order placed with us. We may, at our sole discretion, limit or cancel quantities purchased per person, per household, or per order. These limitations may include orders placed by or under the same customer account, credit card, and/or orders that use the same billing and/or shipping address. If we make changes to or cancel an order, we may attempt to notify you by contacting the email and/or phone number provided at the time of ordering. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers, or distributors.',
        ),
        Text(
          'You agree to provide accurate, complete, and up-to-date account information for all purchases made on our website. You also agree to promptly update your account and other information, including your email address and credit card information, so that we can complete your transactions and contact you as needed.\n',
        ),
        Text(
          'SECTION 5 - PRODUCTS OR SERVICES\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'All our products and services are exclusively available online through our website. These products or services may have limited quantities and are subject to return or exchange only according to our return policy.',
        ),
        Text(
          'We have made every effort to display, as accurately as possible, the colors and images of our products. However, we cannot guarantee that your computer screen’s display of any color will be accurate.',
        ),
        Text(
          'We reserve the right, but are not obliged, to limit the sales of our products or services to any person, geographic region, or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at any time without notice, at our sole discretion. Any offer for any product or service made on this site is void where prohibited. We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.\n',
        ),
        Text(
          'SECTION 6 - MODIFICATIONS TO THE SERVICE AND PRICES\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Prices for our products are subject to change at any time without notice.',
        ),
        Text(
          'We reserve the right to modify or discontinue the Service, or any part thereof, at any time without notice.',
        ),
        Text(
          'We shall not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Service.\n',
        ),
        Text(
          'SECTION 7 - OPTIONAL TOOLS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'During your use of the Website, we may provide you with third-party tools. These tools are provided “as is” and “as available” without any warranty, representation, or guarantee of any kind and without any endorsement. We shall have no liability arising from or relating to your use of optional third-party tools.',
        ),
        Text(
          'Your use of optional tools offered through our Website is entirely at your own risk and discretion. You should ensure that you are familiar with and approve the terms on which the tools are provided by the relevant third-party provider.',
        ),
        Text(
          'In the future, we may offer new services or features through the Website, including new tools and resources. Such new features and/or services shall also be subject to these Terms.\n',
        ),
        Text(
          'SECTION 8 - THIRD PARTY LINKS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Certain content, products, and services available via our Website and Service may include materials from third parties. Third-party links on the Website may direct you to third-party websites that are not affiliated with us. We are not responsible for examining content, and we shall not be liable or responsible for any third-party materials or websites, or for any other materials, products, or services of third parties.',
        ),
        Text(
          'We are not liable for any harm or damages related to the purchases or use of goods, services, resources, content, or any other transactions made in connection with third-party websites. Please review the third party’s policies carefully and ensure you understand them before engaging in any transaction. Any complaints, claims, concerns, or questions regarding third-party products should be directed towards the third party.\n',
        ),
        Text(
          'SECTION 9 - USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'If, at our request, you send specific submissions or, without a request from us, you send creative ideas, suggestions, proposals, plans, or other materials whether online, by email, or otherwise (collectively ‘Comments’), you agree that we may, at any time and without restriction, edit, copy, publish, distribute, and otherwise use in any medium any comments that you forward to us. We shall be under no obligation to maintain any comments in confidence, pay compensation for any comments, or respond to any comments.',
        ),
        Text(
          'We may, but are not obligated to, edit, monitor, or remove any content that we determine at our sole discretion is unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene, or otherwise objectionable or in violation of any party’s intellectual property or these Terms.',
        ),
        Text(
          'You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality, or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive, or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website.',
        ),
        Text(
          'You may not use a false email address, pretend to be someone other than yourself, or otherwise mislead us or third parties as to the origin of any comments. You are solely responsible for any comments you make and the correctness of them. We take no responsibility and assume no liability for any comments posted by you or any third party.\n',
        ),
        Text(
          'SECTION 10 - PERSONAL INFORMATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Your submission of personal information through the store is governed by our Privacy Policy.\n',
        ),
        Text(
          'SECTION 11 - ERRORS, INACCURACIES AND OMISSIONS\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Occasionally there may be information on our website or in the Service that contains typographical errors, inaccuracies, or omissions that may relate to product descriptions, pricing, promotions, offers, transit times, and availability. We reserve the right to correct any errors, inaccuracies, or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order).',
        ),
        Text(
          'We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website should be taken to indicate that all information in the Service or on any related website has been modified or updated.\n',
        ),
        Text(
          'SECTION 12 - PROHIBITED USES\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'In addition to other prohibitions as set forth in the Terms, you are prohibited from using the website or its content: for any unlawful purpose; to solicit others to perform or participate in any unlawful acts; to violate any international, federal, provincial, or state regulations, rules, laws, or local ordinances; to infringe upon or violate our intellectual property rights or the intellectual property rights of others; to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; to submit false or misleading information; to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; to collect or track the personal information of others; to spam, phish, pharm, pretext, spider, crawl, or scrape; for any obscene or immoral purpose; or to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.\n',
        ),
        Text(
          'SECTION 13 - DISCLAIMER OF WARRANTIES, LIMITATION OF LIABILITY\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'We do not guarantee, represent or warrant that your use of our Service will be uninterrupted, timely, secure or error-free.',
        ),
        Text(
          'We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.',
        ),
        Text(
          'You agree that from time to time we may remove the Service for indefinite periods of time or cancel the service at any time, without notice to you.',
        ),
        Text(
          'You expressly agree that your use of, or inability to use, the Service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided ‘as is’ and ‘as available’ for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.',
        ),
        Text(
          'In no case shall Bulkhub, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation, lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability, or otherwise, arising from your use of any of the Service or any products procured using the Service, or for any other claim related in any way to your use of the Service or any product, including without limitation, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the Service or any content (or product) posted, transmitted, or otherwise made available via the Service, even if advised of their possibility. Due to some states or jurisdictions not allowing the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.\n',
        ),
        Text(
          'SECTION 14 - INDEMNIFICATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'You agree to indemnify, defend and hold harmless Bulkhub and our subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys’ fees, made by any third-party due to or arising out of your breach of these Terms or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.\n',
        ),
        Text(
          'SECTION 15 - SEVERABILITY\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'In the event that any provision of these Terms is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms, such determination shall not affect the validity and enforceability of any other remaining provisions.\n',
        ),
        Text(
          'SECTION 16 - TERMINATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes.',
        ),
        Text(
          'These Terms are effective unless and until terminated by either you or us. You may terminate these Terms at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.',
        ),
        Text(
          'If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).\n',
        ),
        Text(
          'SECTION 17 - ENTIRE AGREEMENT\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'The failure of us to exercise or enforce any right or provision of these Terms shall not constitute a waiver of such right or provision.',
        ),
        Text(
          'These Terms and any policies or operating rules posted by us on this site or in respect to the Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including without limitation, any prior versions of the Terms).',
        ),
        Text(
          'Any ambiguities in the interpretation of these Terms shall not be construed against the drafting party.\n',
        ),
        Text(
          'SECTION 18 - GOVERNING LAW\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'These Terms and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the laws of South Africa.\n',
        ),
        Text(
          'SECTION 19 - CHANGES TO TERMS OF SERVICE\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'You can review the most current version of the Terms of Service at any time on this page.',
        ),
        Text(
          'We reserve the right, at our sole discretion, to update, change or replace any part of these Terms by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms constitutes acceptance of those changes.\n',
        ),
        Text(
          'SECTION 20 - CONTACT INFORMATION\n',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Questions about the Terms of Service should be sent to us at helpdesk@bulkhub.co.za.',
        ),
      ],
    );
  }
}