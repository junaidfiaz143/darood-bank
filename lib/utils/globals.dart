import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myTextStyle = GoogleFonts.quicksand(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
);

late double globalLongitude = 0.0;
late double globalLatitude = 0.0;

late String fcmId = "";

late BuildContext globalContext;

late bool isUpdateSkip = false;

late Set<String> bookingNos = {};

late String token;

late String riderId;

late String discount;

late String promoDiscount = "0";

late bool online = false;

late List<String> cities = [];

late String globalLocalCity = "";

late List<String> laboratories = [];
late List<String> laboratoriesID = [];

List<String> privacyPolicy = [
  "Thank you for visiting our web site. This privacy policy tells you how we use personal information collected at this site. Please read this privacy policy before using the site or submitting any personal information. By using the site, you are accepting the practices described in this privacy policy. These practices may be changed, but any changes will be posted and changes will only apply to activities and information on a going forward, not retroactive basis. You are encouraged to review the privacy policy whenever you visit the site to make sure that you understand how any personal information you provide will be used.",
  "\n\nNote: ",
  "The privacy practices set forth in this privacy policy are for this web site and Virtual Lab Apps only. \n\nWe reserve the right to make changes to this policy. Any changes to this policy will be posted. ",
  "\n\nCollection information",
  "\nWe collect personally identifiable information, like names, postal addresses, email addresses, etc., when voluntarily submitted by our visitors.",
  "\n\nCookies/Tracking Technology",
  "\nThe Site may use cookie and tracking technology depending on the features offered. Cookie and tracking technology are useful for gathering information such as browser type and operating system, tracking the number of visitors to the Site, and understanding how visitors use the Site. Cookies can also help customize the Site for visitors. Personal information cannot be collected via cookies and other tracking technology; however, if you previously provided personally identifiable information, cookies may be tied to such information. Aggregate cookie and tracking information may be shared with third parties.",
  "\n\nDistribution of Information",
  "\nWe may share information with governmental agencies or other companies assisting us in fraud prevention or investigation. We may do so when:\n  ➊ permitted or required by law; or,\n  ➋ trying to protect against or prevent actual or potential fraud or unauthorized transactions; or, \n  ➌ investigating fraud which has already taken place. \nThe information is not provided to these companies for marketing purposes.",
  "\n\nCommitment to Data Security",
  "\nYour personally identifiable information is kept secure. Only authorized employees, agents and contractors (who have agreed to keep information secure and confidential) have access to this information. All emails and newsletters from this site allow you to opt out of further mailings.",
  "\n\nPrivacy Contact Information",
  "\nIf you have any questions, concerns, or comments about our privacy policy you may contact us."
];

List<String> aboutUs = [
  "Virtual Lab is Pakistan's first fully automated diagnostic laboratory with a focus on providing quality at affordable costs to laboratories and hospitals in Pakistan and other countries.",
  "\n\nVirtual Lab operates with a Centralized Processing Laboratory (CPL) in Wah Cantt - Pakistan for esoteric tests; and Regional Processing Laboratory in major metro cities of Pakistan and other parts of Asia. We have focused on strong technologies, strong brands and strong systems that enable us to give our clients the best of science and technology at an affordable cost.",
  "\n\nWith a belief that 'Quality' is the heart of any intelligent management, Virtual Lab became one of the first Pakistan diagnostic laboratories to obtain internationally renowned quality accreditations like ISO 9001-2000 rating as early as 2001, which is now escalated to ISO 9001:2008 and CAP (College of American Pathologists) certification in 2020.",
  "\n\nOur clear focus on speed and accuracy further made us the first Pakistan laboratory to also have an IT enabled, 24x7, fully automated diagnostic laboratory set up covering over 2,00,000 sq. ft. floor space that ensures error-free processing of over 1,00,000 specimens and over 4,00,000 Clinical Chemistry investigations per night. Our unmatched speed factor is achieved through a combination of air-cargo logistics and IT enabled, barcoded, bi-directional systems that ensures a turnaround time of 4 to 8 hours for processing of samples that arrive at any time of the day or night.",
  "\n\nMeticulously created and monitored systems, well-chosen and trained manpower, wise selection of the best global technologies for specialized testing and an uncompromised approach to instrumentation has ensured that Virtual Lab is looked upon as a yardstick for quality by stakeholders in the diagnostic industry. The uniqueness of Virtual Lab is its effort to innovate and remain at par of the global standards for best of quality service delivery, at the most cost-effective prices.",
  "\n\nMany laboratories and hospital brands in Pakistan, Middle East and South East Asian countries use Virtual Lab to complete their menu and deliver quality at an affordable cost.",
  "\n\nOur Network",
  "\n\nNetworks of authorized, trained and equipped collection centers served through a very strong IT and Logistics.",
  "\n\nOur Differentiators",
  "\n  ●	Unique concept - Virtual Lab operates with a Centralized Processing Laboratory (CPL) in Mumbai - Pakistan for esoteric tests; and Regional Processing Laboratory in major metro cities of Pakistan and other parts of Asia.",
  "\n  ●	Unique focus - We focus on clinical chemistry and preventive care diagnosis.",
  "\n  ●	Unique air-cargo logistics - which ensure the samples, reach our laboratory every night, same night, before midnight.",
  "\n  ●	Unique operations - Our laboratory works 24 x 7 to cater to the needs of our customers.",
  "\n  ●	Aptio (Siemens)- World’s largest and longest laboratory track automation- 1st  time in Pakistan.",
  "\n  ●	Pakistan’s first pre-analytical barcoded vial sorter (MUT) and Sample Sorter (Roche).",
  "\n\nOur Strengths",
  "\n\nQuality",
  "\nBest of the Global brands, Best of their instruments, Best of the technologies, Best of the reagents, Best of the procedures, Best of systems, Best of IT when available to well - trained and highly focused Pathologists, Biochemists, Scientists and Technologists gives Best of the Quality.",
  "\n\nSystem",
  "\nIT when used ideally to integrate men, machines and methods, it delivers secured, assured, reliable and reproducible solutions even in Diagnostic industry. Analyzers, web-servers and barcodes when integrated, it gives a system that is empowered, controlled and monitored end to end.",
  "\n\nReach",
  "\nWith more and more brands using us as their cost-effective backend laboratory, our presence grows in more and more cities, countries and continents. Today, Virtual Lab boasts of processing 3 billion investigations in a year and having a capacity to process 10 billion in a year.",
  "\n\nCost",
  "\nWorking on Value makes a lot of sense when the operations are B2C. However, when the focus is B2B, volume makes a great sense. Hence, Virtual Lab has been working on cost of retail reagents for its services. A fully optimized, highly efficient, seamless automation has ensured men, material and machines delivering highest level of quality services at affordable (UNBELIEVABLE) costs.",
  "\n\nSpeed",
  "\nLaboratory functions 24X7. Air-cargo functions 24 X 7. Barcoded, Bi-directionally interfaced and web server solutions enhance the speed and allow every laboratory in any continent to operate our machines as if they are present on their floor, generating results and reports within 5 hours of flight touching the runway.",
  "\n\nFocus",
  "\nOur clear focus is to facilitate and standardize quality and cost of laboratory services across the world. By helping laboratories to outsource numerical pathology tests (clinical chemistry), the quality of services are ensured by a username / password. Since the costs make economic sense for laboratories which lack volumes, this unique B2B focus helps the industry. Logically, we focus more on preventive care than sick care."
];

List<String> termsAndConditions = [
  "CONFIDENTIALITY",
  "\nVirtual Lab is an independent testing laboratory. Testing services are our only business. We maintain strict confidentiality of all client information. We will execute your confidentiality agreements or we can provide you with copies of our standard agreement.",
  "\n\nQUALITY AGREEMENTS",
  "\nSome companies require quality agreements with their key vendors. We will review and execute your quality agreement or we can provide you with a copy of our standard agreement. Our sales or QA staff can make arrangements to execute quality agreements.",
  "\n\nQUOTES FOR TESTING SERVICES",
  "\nCustom quotes are required for most sample submissions. Virtual Lab sales staff promptly issues quotes. To receive a quote for your testing needs please complete the online Request for Quotation form.",
  "\n\nPREPAYMENT POLICY",
  "\nFor new clients prepayment is required before testing can be initiated. We also require a payment schedule for certain larger studies, especially in toxicology (e.g. 50% at initiation, 40% at completion of inlife phase, 10% at issue of final report).",
  "\n\nPAYMENT TERMS",
  "\nOur terms are net 10 days upon receipt of our invoice. We accept checks drawn on Pakistan banks, wire transfer or Visa and Master Card Credit Cards. A 1500 per month surcharge will be assessed on accounts not paid within 30 days from phlebotomists. Past due accounts must be made current before new work will be accepted.",
  "\n\nINTERNATIONAL ORDERS",
  "\nComplete documentation is required to facilitate the shipping process for samples sent to the U.S. from other countries. Shipping documents should identify the shipment contents as “SAMPLES FOR TESTING ONLY – NOT FOR HUMAN USE.” Any customs related fees are the responsibility of the client. All invoices are payable in U.S. Dollars. To minimize banking fees, we suggest payment by wire transfer to our bank account.",
  "\n\nTEST FEES",
  "\nThe fees listed in the PBL fee schedule are for tests in which routine procedures are used. Products which require extraordinary handling (e.g. unusual sample preparation, unique laboratory supplies, extra safety measures, disposal of excess hazardous samples, etc.) will incur additional charges.",
  "\nRevisions to USP, international compendia, ISO and other standards may affect test procedures, and consequently test fees, at any time. All fees in the PBL fee schedule are subject to change without notice.",
  "\n\nRUSH SERVICE",
  "\n"
      r"Rush service may incur a surcharge. For regular clients, we try to accommodate occasional special requests to expedite turnaround time for routine tests without assessing any additional charge. However, many rush requests require overtime, weekend or holiday work and result in costly operating inefficiencies and cause significant disruption of our testing schedule. On these occasions, there will be a minimum of $100 or 50% additional charge.",
  "\n\nVOLUME DISCOUNTS",
  "\nVolume discounts are available for many of the tests listed. Please call for a quotation on your volume testing requirements.",
  "\n\nGLP STUDIES",
  "\n"
      r"Some studies that will be submitted to EPA or FDA must be performed according to Good Laboratory Practice regulations. It is the responsibility of the test sponsor to request GLP treatment prior to the initiation of testing. GLP treatment includes a custom protocol approved by the sponsor, observation of the performance of the testing procedure by our Quality Assurance Department, Q.A. review of all test data, and a detailed final report. GLP fees are generally an additional 10 to 20%. The minimum GLP fee is $250.00 per procedure. GLP treatment will generally add 3 to 7 work days to standard turnaround times for routine tests.",
  "\n\nHAZARDOUS SAMPLES",
  "\n"
      r"Special precautions must be taken to safely test hazardous samples. Handling fees will be added to all projects which require work with hazardous or biohazardous agents. These fees will vary depending on the material, the nature of the hazard, and the project protocol. There may also be a fee for sample disposal. We reserve the right to return all hazardous samples to the test sponsor. For hazardous sample return, there is a minimum Hazmat processing fee of $35.00. Shipping charges are additional.",
  "\n\nTEST PROCEDURES",
  "\n"
      r"Virtual Lab has an extensive library of SOPs for commonly performed tests. Most Virtual Lab SOPs are based on USP procedures, ANSI/AAMI/OSP standards or other recognized references. Our library includes the most current editions of the USP, BP, EP, and JP. We welcome client methods. If test methods are not available, we offer method development and validation services.",
  "\n\nMETHODS TRANSFER",
  "\nA method transfer is a study that is performed to verify that a test method developed in one lab can be accurately performed in another lab. The GMP regulations have been interpreted to require method transfer studies for many non compendial test methods. Please call for a quote for a method transfer study for your specific test method.",
  "\n\nVALIDATION OF TESTING PROCEDURES",
  "\nUSP procedures for products listed in the USP are generally considered to be validated. Many other test procedures should be validated for the particular products being tested. It is the client’s responsibility to insure that the validation status of test procedures used on their products is approved by their quality assurance department. The test fees listed in this schedule do not include the validation of that test for the sample that is submitted. Virtual Lab offers test procedure validation services. Please call any of our technical managers to discuss validation issues regarding the test procedures used for your products.",
  "\n\nRETESTS",
  "\nRetesting is generally governed by our SOP for handling out-of-specification findings. Client authorized retesting will be billed accordingly.",
  "\n\nREPORTS",
  "\nAll test results are issued on a clear and accurate Report of Analysis. Virtual Lab’ reporting system allows us substantial flexibility in the preparation of reports. We can generate customized reports to meet special client requirements. Reports will be sent out via First Class Mail unless otherwise requested by the client.",
  "\nReports are submitted for exclusive use by our clients. No reference to the work, the results, or to Virtual Lab may be made in any form of advertising, news release or other public announcement without written authorization.",
  "\n\nELECTRONIC REPORTS",
  "\n"
      r"Lab reports can be sent via email. The report will be an electronic image of the final signed paper copy of the report. The fee for this service is $6.00 per report.",
  "\n\nMINIMUM REPORT FEE",
  "\n"
      r"The minimum fee for testing a sample and issuing a lab report is $70.00.",
  "\n\nREISSUED REPORTS",
  "\nThere is a Pkr. 50.00 minimum charge for a reissued report.",
  "\n\nSAMPLE RETENTION AND RETURN",
  "\nFollowing completion of testing, Virtual Lab will generally discard excess samples in accordance with our sample retention SOP (< 30 days). When requested, we will return remaining samples to the client. There is no shipping expenses for the return of samples. Fees vary according to quantity and weight of samples, special handling or packaging requirements and whether the sample is hazardous. For any single or group of samples submitted concurrently, valued over Pkr 10000.00, and for which return is required, the client must include a declared value. If no value is declared, Virtual Lab cannot be held liable for any amount in excess of Pkr. 10000.00 for any loss of samples, whether at Virtual Lab or lost in transit.",
  "\nFor GLP studies, all unused sample will be held for approximately one month after completion of testing, then returned (unless you instruct us otherwise). The test sponsor is responsible for retaining reserve samples in accordance with FDA and EPA GLP regulations. If the sponsor is unable to meet these requirements, Virtual Lab can store small amounts of reserve sample. The minimum sample storage fee is Pkr. 100.00 per month.",
  "\n\nCOOLER RETURN",
  "\n"
      r"For environmental and/or cost reasons, many clients request that the cooler boxes in which they ship their samples be returned to them. If you want your cooler returned, please note it on your sample submission documents. To cover our expenses, Virtual Lab charges only the return shipping costs plus a $5.00 repackaging fee. Alternatively, we can have the shipping charges billed to your UPS account if you provide us with your UPS shipper number.",
  "\n\nRECORD RETENTION",
  "\n"
      r"For all studies, Virtual Lab retains all report related data and documentation for one year. After 1 year, all paper documentation may be retained upon request of the client, otherwise it will be destroyed.",
  "\nClients who need data and documentation for greater than 1 year can request copies of data at the time of sample submission. There is an additional charge for raw data collection and copying.",
  "\n\nAUDIT POLICY",
  "\nVirtual Lab welcomes prospective client audits of our laboratories and quality systems. There is no charge for an initial audit of up to one full day. We also recognize our clients’ need to re-audit their contract service providers in accordance with their company SOPs. We welcome re-audits of our laboratories. In most cases, there is no fee related to re-audits. Under certain circumstances for extended audit times, an hourly fee will be assessed for hours beyond a preset schedule. If applicable, our QA managers will discuss this when the audit is scheduled.",
  "\n\nPOLICY ON ALTERNATIVE METHODS",
  "\nVirtual Lab encourages the use of non-animal alternatives where available and supports the application of the three R’s – reduction, refinement and replacement. It is a policy at Virtual Lab to keep clients abreast of current testing guidelines as they relate to the prudent use of animals. A senior member of the in vivo testing staff is available to consult with clients regarding alternative methods. Please contact client services at 510/964-9000 with inquiries regarding alternative methods.",
  "\n\nCONDITIONS OF SALE, WARRANTY AND LIMIT OF LIABILITY",
  "\nVirtual Lab provides services to its clients on a fee-for-service basis. All services are performed by Virtual Lab in accordance with the service notes, terms and conditions specified in this fee schedule. Any deviation to the terms must be agreed to in writing by Virtual Lab’ executive management prior to the performance of service.",
  "\nThe only warranty that Virtual Lab offers is that it will perform its services with due care in accordance with Virtual Lab procedures and generally prevailing industry standards and applicable government regulations. The only remedy for breach of this warranty will be to require Virtual Lab to repeat the services or to be credited for fees paid for services performed.",
  "\nTest results are not necessarily indicative of the characteristics of any other samples from the same or any other lots. Virtual Lab assumes no responsibility for any purpose for which a client chooses to use test results. Virtual Lab or its subsidiary companies shall not be liable under any circumstances for any amount in excess of the cost of the test performed.",
  "\nCustom quotes are required for most sample submissions. Virtual Lab sales staff promptly issues quotes. To receive a quote for your testing needs please complete the online Request for Quotation form."
];
