import 'package:mazratii/Models/plantmodel.dart';

import '../Models/taskmodel.dart';

const int Seedling_Stage = 2;
const int Transplanting = 3;
const int Silking_Stage = 3;
const int Flowering = 3;
Plant myCorn = Plant(
  age: 0,
  id: 2,
  time: DateTime.now(),
  season: 'الصيف',
  water: 'متوسطة إلى عالية',
  description:
      'الذرة تحتاج إلى تربة جيدة التصريف ومكان يحصل على أشعة الشمس كاملة. تزرع الذرة بشكل أفضل في درجات حرارة الصيف العالية.',
  spaceId: 124,
  plantName: 'نبات الذرة',
  image: 'corn.jpg',
  tasks: [
    Tasks(
      id: 1,
      name: 'زراعة البذور',
      description:
          'زراعة بذور الذرة مباشرة في التربة بعد مرور خطر الصقيع. يجب أن تكون التربة دافئة، على الأقل 10 درجات مئوية.',
      day: 1,
    ),
    Tasks(
      id: 2,
      name: 'الري الأولي',
      description:
          'ري البذور بعد الزراعة مباشرة لتشجيع الإنبات. حافظ على رطوبة التربة دون إغراقها.',
      day: 2,
    ),
    Tasks(
      id: 3,
      name: 'رعاية النباتات',
      description:
          'أزل الأعشاب الضارة من حول النباتات وحافظ على التربة رطبة، خاصة خلال فترات الجفاف.',
      day: 14,
    ),
    Tasks(
      id: 4,
      name: 'التسميد',
      description:
          'استخدم سماد عالي النيتروجين بعد ظهور الأوراق الأولى لتشجيع النمو القوي.',
      day: 30,
    ),
    Tasks(
      id: 5,
      name: 'التلقيح',
      description:
          'تأكد من زراعة الذرة في مجموعات لتعزيز التلقيح الجيد بواسطة الرياح.',
      day: 50,
    ),
    Tasks(
      id: 6,
      name: 'الري المنتظم',
      description:
          'استمر في الري بانتظام، خاصة خلال مرحلة تكوين الكيزان، وهي حاسمة لتطوير الحبوب.',
      day: 65,
    ),
    Tasks(
      id: 7,
      name: 'الحصاد',
      description:
          'حصد الذرة عندما تصبح الشعرات البنية وتكون الحبوب لينة ولكنها قاسية.',
      day: 90,
    ),
    for (int i = 1; i <= 7; i += Seedling_Stage) ...generateAlternateTasks(i),
    for (int i = 8; i <= 41; i += Transplanting) ...generateAlternateTasks(i),
    for (int i = 42; i <= 77; i += Silking_Stage) ...generateAlternateTasks(i),
    for (int i = 77; i <= 101; i += Flowering) ...generateAlternateTasks(i),
  ],
  Duration_of_growth: '90 إلى 100 يوم',
);
List<Tasks> generateAlternateTasks(int startDay) {
  return [
    Tasks(
      id: 7,
      name: 'الري',
      description: 'الحفاظ على التربة رطبة، ولكن ليس مشبعة بالمياه، ',
      day: startDay,
    ),
  ];
}
