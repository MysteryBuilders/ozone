import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Constants{
  static const String testAPIKey =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

//TODO Get your google merchant id
  static const String googleMerchantId = "your_google_merchant_id";
  static const String privacyContent ='''
  <div class="privacy-policy cms-content">
    <h2>سياسة الاستبدال والإرجاع:</h2>
    <p>نحن في أوزون نعمل على توفير بضائع بأعلى مستوى من الجودة مما يضمن لعملائنا الحصول على المنتجات حسب المواصفات المطلوبة، إلا أنه يمكن لعملائنا الكرام استبدال أو إرجاع مشترياتهم ضمن الشروط والأحكام التالية:</p>
    <ul>
        <li>في أوزون نبذل قصارى جهدنا لضمان رضاكم التام عن خدماتنا ويسعدنا استبدال المنتج في حالة وجود أي مشكلة سواء كان تالفًا أو غير مطابق للمواصفات أو غير صحيح دون أي رسوم إضافية ويرجى من عملائنا الكرام إبلاغنا خلال 24 ساعة، يرجى ملاحظة أننا لن نتحمل المسؤولية عن أي مشاكل في التسليم إذا لم تبلغنا خلال 24 ساعة من الاستلام.</li>
        <li>تخضع الأدوية وتنظيم بيعها وتداولها للقرارات والأنظمة واللوائح الوزارية، بما ينص على منع إسترجاعها أو استبدالها وفقا لتعميم وزارة الصحة رقم 32/2023.</li>
        <li>يطبق التعميم رقم 2/2013 وما يتضمنه تنظيم ومنع الإرجاع أو الاستبدال على المنتجات الغذائية والنباتية والمكملات الغذائية.</li>
        <li>سياسة الأجهزة والمعدات ومستلزمات التجميل وفقًا لقانون وزارة التجارة، لدى العملاء 14 يومًا لطلب الإرجاع أو الاستبدال وفقًا للشروط التالية:

            <ol>
                <li>يجب أن تكون البضاعة المراد استبدالها أو إرجاعها في حالة جيدة وقابلة للبيع مرة أخرى وبنفس حالة الشراء (أي لم يتم فتح العبوه) وفي العبوة الأصلية ومرفقة بالإيصال الأصلي.</li>
                <li>إلى عملائنا الكرام خارج الكويت، في حالة الرغبة في إرجاع الطلب بعد استلامه سليما دون أي أضرار، يتحمل العميل تكلفة الشحن من خلال شركات خدمات الشحن التالية فقط: (DHL، Aramex) بشرط أن تكون البضاعة المراد إعادتها بحالتها الأصلية (غير مستخدمة ومع عبوتها). ومن بين المنتجات المسموح بإرجاعها وإرفاقها بإيصال الشراء الأصلي، يتم استرداد المبالغ المدفوعة بعد خصم أي ضريبة أو رسوم جمركية وبعد خصم رسوم الشحن والتوصيل، وبعد التأكد من حالة الأصناف.</li>
            </ol>

        </li>
        <li>وصف المنتج وألوانه: لقد بذلنا قصارى جهدنا لعرض وصف ولون المنتجات المعروضة على موقعنا بأكبر قدر ممكن من الدقة. ومع ذلك، فإننا نعتمد على المعلومات المقدمة لنا من قبل الموردين لدينا وقد تختلف ألوان التغليف حسب شاشات الكمبيوتر المختلفة. وعليه يحق لنا رفض إرجاع أو استبدال أي منتج بموجب هذا البند.</li>
    </ul>
    <h2>سياسة استرداد الاموال :</h2>
    <ul>
        <li>في حالة الإرجاع يكون استرداد المبالغ المدفوعة بنفس طريقة الدفع وقت الشراء.</li>
        <li>في حالة استرداد المبالغ المدفوعة مسبقاً عبر بطاقات الائتمان، يكون استرداد المبالغ المدفوعة وفقاً لنفس بيانات البطاقة ولنفس العميل مع مراعاة المدة الزمنية لإتمام العملية.</li>
        <li>مدة الإرجاع تكون داخل الكويت خلال 3 إلى 5 أيام عمل وخارج الكويت خلال 7 إلى 14 يوم عمل.</li>
        <li>في حالة طلب العميل استرداد الأموال، سيتم خصم رسوم التحويل من المبلغ الإجمالي للعميل.</li>
    </ul>
    <h2>سياسة التوصيل :</h2>
    <ul>
        <li>التوصيل مجاني لجميع مناطق الكويت.</li>
        <li>يتم توصيل الطلبيات داخل الكويت خلال 48 ساعة.</li>
        <li>يتم توصيل الطلبيات إلى جميع دول الخليج خلال 3 إلى 7 أيام عمل.</li>
    </ul>

    <h2>سياسة الدفع :</h2>
    <ul>
        <li>يمكن للعملاء الدفع مقابل طلباتهم عبر الإنترنت من خلال بطاقة الائتمان وبطاقة الخصم وشبكة K-Net.</li>
        <li>لعملائنا الكرام خارج الكويت يتم سحب المبالغ بالدينار الكويتي، يرجى مراعاة فرق العملة.</li>
    </ul>
</div>''';

  static const String baseUrl ="https://ozone-pharmacy.com/rest/";
  // static const String baseUrl ="https://ozone.cubicit-eg.com/index.php/rest/V1";
  //  static const String baseUrl ="https://staging.ozone-pharmacy.com/rest/default/V1";
  static const String paymentUrl ="https://myacad.app/index.php";
  static const String privacyUrl ="https://ozone-pharmacy.com/privacy-policy-cookie-restriction-mode/";
  static const String empty="";
  static const String url="url";
  static const String invoiceId="invoiceId";
  static const String typeId="type";
  static const int token=965;
  static const int zero =0;
  static  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static const double zeroDouble =0.0;
  static const bool falseBoolean =false;
  static const String title="title";
  static const String text="text";
  static const String list="List";
  static const String name="name";
  static const String academyId="id";
  static const String orderId="orderId";
  static const String userId="userId";
  static const String userModel="userModel";
  static const String clothesImage ="clothesImage";
  static const String academyDetails ="academyDetails";
  static const String subscriptionModel ="subscriptionModel";
  static const String sessionModel ="sessionModel";
  static const String clothesModel ="clothesModel";
  static const String clothesCount="clothesCount";
  static const String subscriptionId ="subscriptionId";
  static const String sessionId ="sessionId";
  static const String studentNumbers ="studentNo";
  static const int apiTimeOut =60*1000*60*5;
  static const String headerKey ="Authorization";
  static const String stateId = "state_id";
  static const String deviceType = "device_type";
  static const String storeCode = "store_code";
  static const String headerValue ="Bearer luxwsm7p713kf256us6ne9f55b8rhiyf";
  static const String baseImageUrl="https://admincp.trycraneapp.com/";
  static const googleMapsKey="AIzaSyBuENsRwpqXmw2lcAGCjY1QwqCKkHGQujA";
  static bool isEnabled = false;
  static bool isDismissed = false;
  static const googlePlacesUrl="https://maps.googleapis.com/maps/api/";
  static const domain = "https://ozone-pharmacy.com";
  static const kDefaultImage =
      'https://trello.com/1/cards/5d64f19a7cd71013a9a418cf/attachments/5df37e7dc660f72ec2a6b147/previews/5df37e7ec660f72ec2a6b14f/download/placeholder.jpg';

}