import 'package:mazratii/Models/plantmodel.dart';
import '../Models/taskmodel.dart';

const int Seedling_Stage = 2;
const int Transplanting = 3;
const int Vegetative_Growth = 3;
const int Flowering = 3;
const int Ripening = 3;

Plant myPotato = Plant(
  age: 0,
  id: 1,
  time: DateTime.now(),
  season: 'الربيع',
  water: 'مرتفعة',
  description:
      'تعتبر نباتات البطاطا سهلة الزراعة ومناسبة للمناخات المعتدلة إلى الباردة. تفضل البطاطا التربة الغنية بالمواد العضوية جيدة التصريف مع التعرض لأشعة الشمس الكاملة لمدة 6-8 ساعات يوميًا.',
  spaceId: 123,
  plantName: 'نبات البطاطا',
  image: 'potato.jpeg',
  tasks: [
    Tasks(
      id: 1,
      name: 'جمع المستلزمات',
      description:
          'جمع البذور (البطاطا الصغيرة) وليس البذور المجففة، والصواني ومزيج التربة وبخاخ الماء ومكان مشمس',
      day: 1,
    ),
    Tasks(
      id: 2,
      name: 'تحضير البذور (البطاطا الصغيرة)',
      description:
          'اختر بطاطا صغيرة بحجم بيضة الجولف خالية من العيوب والعفن. اقطع كل بطاطة إلى قطع تحتوي على 1-2 عين (براعم) على الأقل.',
      day: 1,
    ),
    Tasks(
      id: 3,
      name: 'زراعة البذور (القطعة المقطوعة)',
      description:
          'ازرع جانب البذرة المقطوعة (حيث توجد البراعم) لأسفل على عمق 2-3 سم في التربة مع ترك مسافة 30 سم بين كل قطعة.',
      day: 1,
    ),
    Tasks(
      id: 4,
      name: 'الري',
      description:
          'الحفاظ على التربة رطبة ولكن ليس مشبعة بالمياه. تأكد من تصريف الماء الزائد لمنع تعفن الجذور. قلل الري قليلاً بعد ظهور البراعم الخضراء.',
      day: 1,
    ),

    // Add repetitive tasks directly to the Tasks list within Plant object
    for (int i = 1; i <= 35; i += Seedling_Stage) ...generateAlternateTasks(i),
    for (int i = 36; i <= 50; i += Transplanting) ...generateAlternateTasks(i),
    for (int i = 51; i <= 100; i += Vegetative_Growth)
      ...generateAlternateTasks(i),
    for (int i = 100; i <= 120; i += Flowering) ...generateAlternateTasks(i),
    for (int i = 100; i <= 120; i += Ripening) ...generateAlternateTasks(i),

    Tasks(
      id: 10,
      name: 'تجميع التربة حول السيقان',
      description:
          'بمجرد أن يصل ارتفاع سيقان نباتات البطاطا إلى 15-20 سم، قم بتجميع التربة حول السيقان برفق لتوفير الدعم ومكافحة الأعشاب الضارة.',
      day: 61,
    ),
    Tasks(
      id: 11,
      name: 'تثبيت إضافي (اختياري)',
      description:
          'يمكنك أيضًا استخدام أعمدة أو أسلاك لتثبيت سيقان نباتات البطاطا خاصة في حال كانت طويلة أو ضعيفة.',
      day: 68,
    ),
    Tasks(
      id: 12,
      name: 'متابعة تجميع التربة (اختياري)',
      description: 'استمر في تجميع التربة حول السيقان مع نمو النباتات.',
      day: 75,
    ),
    Tasks(
      id: 13,
      name: 'التسميد',
      description:
          'بعد ظهور البراعم الخضراء، ابدأ بتسميد نباتات البطاطا بانتظام كل 2-3 أسابيع باستخدام سماد متوازن مثل 10-10-10. يساعد التسميد على نمو أوراق وأزهار قوية وإنتاج وفير من البطاطا.',
      day: 80,
    ),
    Tasks(
      id: 14,
      name: 'التسميد',
      description: 'استمر في تسميد نباتات البطاطا بانتظام وفقًا للجدول الزمني.',
      day: 95,
    ),
    Tasks(
      id: 15,
      name: 'فحص النباتات',
      description:
          'افحص نباتات البطاطا بانتظام بحثًا عن الآفات والأمراض الشائعة مثل: خنفسة البطاطا الكولورادو، وتعفن الأطراف، والجرب. اتخذ إجراءات مناسبة للسيطرة عليها إذا لزم الأمر.',
      day: 82,
    ),
    Tasks(
      id: 16,
      name: 'فحص النباتات',
      description: 'استمر في فحص نبتات البطاطا بانتظام.',
      day: 89,
    ),
    Tasks(
      id: 17,
      name: 'فحص النباتات',
      description: 'استمر في فحص نبتات البطاطا بانتظام.',
      day: 97,
    ),
    Tasks(
      id: 18,
      name: 'الري (خفف عند الحاجة)',
      description:
          'استمر في ري نباتات البطاطا بانتظام، خاصة خلال فترات الطق الجاف والحار. قلل من الري قليلاً عند اقتراب موعد الحصاد لمنع تشقق البطاطا.',
      day: 110,
    ),
    Tasks(
      id: 19,
      name: 'الري (خفف أكثر)',
      description:
          'قلل من كمية المياه المستخدمة في الري أكثر خلال الأسبوع الذي يسبق الحصاد.',
      day: 125,
    ),
    Tasks(
      id: 20,
      name: 'الحصاد',
      description:
          'يمكنك حصاد البطاطا عندما تذبل الأوراق وتتحول إلى اللون الأصفر. احفر بعناية حول النبات واستخرج البطاطا برفق باستخدام شوكة أو مجرفة يدوية.',
      day: 120,
    ),
    Tasks(
      id: 21,
      name: 'استمتع بحصادك!',
      description:
          'لقد نجحت في زراعة البطاطا! استمتع بالبطاطا اللذيذة التي قمت بزراعتها.',
      day: 130,
    ),
  ],
  Duration_of_growth: '130 إلى 110 يومًا',
);

List<Tasks> generateWeeklyTasks(int startDay) {
  return [
    Tasks(
      id: 8,
      name: 'التأكد من اشعة الشمس',
      description:
          'تأكد من حصول نباتات البطاطا على 6-8 ساعات يوميًا من أشعة الشمس الكاملة.',
      day: startDay,
    ),
    Tasks(
      id: 9,
      name: 'ازالة الاعشاب الضارة',
      description:
          'تخلص من أي أعشاب ضارة تنمو بالقرب من نباتات البطاطا لمنع المنافسة على الماء والمغذيات.',
      day: startDay,
    ),
  ];
}

List<Tasks> generateAlternateTasks(int startDay) {
  return [
    Tasks(
      id: 7,
      name: 'الري',
      description:
          'الحفاظ على التربة رطبة ولكن ليس مشبعة بالمياه. تأكد من تصريف الماء الزائد لمنع تعفن الجذور.',
      day: startDay,
    ),
  ];
}
