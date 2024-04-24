import 'package:mazratii/Models/plantmodel.dart';

import '../Models/taskmodel.dart';

const int Seedling_Stage = 2;
const int Transplanting = 3;
const int Vegetative_Growth = 3;
const int Flowering = 3;
const int Ripening = 3;

Plant myTomato = Plant(
    age: 0,
    id: 1,
    time: DateTime.now(),
    season: 'الربيع ',
    water: 'مرتفعة',
    description:
        'نبتة الطماطم تُعتبر سهلة الزراعة ومناسبة للزراعة في المناطق ذات المناخ المعتدل إلى الحار. تحتاج الطماطم إلى أرضية جيدة التصريف وغنية بالمواد العضوية، مع تعريضها لأشعة الشمس المباشرة لمدة تتراوح بين 6 إلى 8 ساعات يوميًا. يُفضل زراعة الطماطم في التربة التي تكون pH قريبًا من القيمة المتعادلة.',
    spaceId: 123,
    plantName: 'نبتة الطماطم',
    image: 'tomato.jpeg',
    tasks: [
      Tasks(
        id: 1,
        name: 'جمع المستلزمات',
        description:
            'جمع البذور، والصواني، ومزيج التربة، وبخاخ الماء، ومكان مشمس',
        day: 1,
      ),
      Tasks(
        id: 2,
        name: 'زراعة البذور',
        description: 'زرع البذور وفقًا لإرشادات العبوة (عادةً بعمق ربع بوصة)',
        day: 1,
      ),
      Tasks(
        id: 3,
        name: 'الضوء',
        description: 'توفير 16 ساعة من ضوء الشمس غير المباشر يوميًا',
        day: 1,
      ),

      // Add repetitive tasks directly to the Tasks list within Plant object
      for (int i = 1; i <= 35; i += Seedling_Stage)
        ...generateAlternateTasks(i),
      for (int i = 36; i <= 50; i += Transplanting)
        ...generateAlternateTasks(i),
      for (int i = 51; i <= 100; i += Vegetative_Growth)
        ...generateAlternateTasks(i),
      for (int i = 100; i <= 120; i += Flowering) ...generateAlternateTasks(i),
      for (int i = 100; i <= 120; i += Ripening) ...generateAlternateTasks(i),

      Tasks(
        id: 10,
        name: 'تثبيت النباتات',
        description:
            'قم بربط النباتات بأعمدة أو أسلاك لدعم نموها ومنع انحنائها',
        day: 61,
      ),
      Tasks(
        id: 10,
        name: 'تثبيت النباتات',
        description:
            'قم بربط النباتات بأعمدة أو أسلاك لدعم نموها ومنع انحنائها',
        day: 68,
      ),
      Tasks(
        id: 10,
        name: 'تثبيت النباتات',
        description:
            'قم بربط النباتات بأعمدة أو أسلاك لدعم نموها ومنع انحنائها',
        day: 75,
      ),
      Tasks(
        id: 8,
        name: 'التسميد',
        description:
            'من المهم تسميد الطماطم بانتظام خلال فترة نموها، ويُفضل ذلك بمعدل مرتين شهريًا باستخدام سماد متوازن مثل 5-5-5 أو 5-10-5.',
        day: 80,
      ),
      Tasks(
        id: 8,
        name: 'التسميد',
        description:
            'من المهم تسميد الطماطم بانتظام خلال فترة نموها، ويُفضل ذلك بمعدل مرتين شهريًا باستخدام سماد متوازن مثل 5-5-5 أو 5-10-5.',
        day: 95,
      ),
      Tasks(
        id: 11,
        name: 'فحص النباتات',
        description:
            'افحص النباتات بشكل منتظم للتأكد من عدم وجود آفات أو أمراض.',
        day: 82,
      ),
      Tasks(
        id: 11,
        name: 'فحص النباتات',
        description:
            'افحص النباتات بشكل منتظم للتأكد من عدم وجود آفات أو أمراض.',
        day: 89,
      ),
      Tasks(
        id: 11,
        name: 'فحص النباتات',
        description:
            'افحص النباتات بشكل منتظم للتأكد من عدم وجود آفات أو أمراض.',
        day: 97,
      ),
      Tasks(
        id: 8,
        name: 'التسميد',
        description:
            'من المهم تسميد الطماطم بانتظام خلال فترة نموها، ويُفضل ذلك بمعدل مرتين شهريًا باستخدام سماد متوازن مثل 5-5-5 أو 5-10-5.',
        day: 110,
      ),
      Tasks(
        id: 8,
        name: 'التسميد',
        description:
            'من المهم تسميد الطماطم بانتظام خلال فترة نموها، ويُفضل ذلك بمعدل مرتين شهريًا باستخدام سماد متوازن مثل 5-5-5 أو 5-10-5.',
        day: 125,
      ),
      Tasks(
        id: 11,
        name: 'الحصاد',
        description: 'الحصاد.',
        day: 120,
      ),
      Tasks(
        id: 11,
        name: 'الحصاد',
        description: 'الحصاد.',
        day: 130,
      ),
      // Add other non-repetitive tasks here
    ],
    Duration_of_growth: '60 إلى 80 يومًا');

List<Tasks> generateWeeklyTasks(int startDay) {
  return [
    Tasks(
      id: 8,
      name: 'تسميد البادرات',
      description:
          'استخدم الأسمدة السائلة المخففة بالماء لتغذية النباتات الصغيرة بشكل آمن وفعال',
      day: startDay,
    ),
    Tasks(
      id: 8,
      name: 'التأكد من اشعة الشمس',
      description:
          'إذا كانت الأماكن مشمسة جدًا، فكر في توفير بعض الظلال للبادرات الصغيرة.',
      day: startDay,
    ),
    Tasks(
      id: 9,
      name: 'ازالة الاعشاب الضارة',
      description:
          'إذا كان هناك أعشاب ضارة تظهر حول النباتات، قم بإزالتها يدويًا.',
      day: startDay,
    ),
  ];
}

List<Tasks> generateAlternateTasks(int startDay) {
  return [
    Tasks(
      id: 7,
      name: 'الري',
      description: 'الحفاظ على التربة رطبة، ولكن ليس مشبعة بالمياه، ',
      day: startDay, // الري يوميًا خلال الإنبات
    ),
  ];
}
