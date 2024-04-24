import 'package:mazratii/Models/plantmodel.dart';
import '../Models/taskmodel.dart';

const int Germination_Stage =
    5; // Days between watering and checks in germination stage
const int Vegetative_Stage = 10; // Days between care tasks in vegetative stage
const int Tillering_Stage = 7; // Days between observations during tillering
const int Heading_Stage = 5; // Days during heading phase
const int Maturation_Stage = 10; // Days leading up to harvest

Plant myBarley = Plant(
    age: 0,
    id: 3,
    time: DateTime.now(),
    season: 'الخريف',
    water: 'متوسطة',
    description:
        'الشعير نبات متين يمكن زراعته في مجموعة متنوعة من البيئات. يفضل تربة جيدة التصريف ويحتاج إلى شمس كاملة. يجب زراعة الشعير في التربة التي تم تحضيرها جيدًا بتعديلات عضوية.',
    spaceId: 126,
    plantName: 'نبتة الشعير',
    image: 'Chiir.jpeg',
    tasks: [
      Tasks(
        id: 1,
        name: 'تحضير الأرض وزراعة البذور',
        description: 'حرث الأرض وزراعة بذور الشعير بعمق حوالي 2-3 سنتيمترات.',
        day: 1,
      ),
      Tasks(
        id: 2,
        name: 'الري الأولي',
        description: 'ري البذور بعد زراعتها لتعزيز الإنبات.',
        day: 2,
      ),

      // Repetitive watering and care tasks during critical stages
      for (int i = 3; i <= 20; i += Germination_Stage)
        ...generateWateringTasks(i, 'الحفاظ على رطوبة التربة دون تشبع.'),
      for (int i = 21; i <= 50; i += Vegetative_Stage)
        ...generateWateringTasks(i, 'تأكد من رطوبة التربة خلال النمو الخضري.'),
      for (int i = 51; i <= 80; i += Tillering_Stage)
        ...generateWateringTasks(i, 'رصد النباتات وضبط الري حسب الحاجة.'),
      for (int i = 81; i <= 110; i += Heading_Stage)
        ...generateWateringTasks(
            i, 'توفير الماء بشكل متوازن خلال مرحلة النمو الرئيسية.'),
      for (int i = 111; i <= 140; i += Maturation_Stage)
        ...generateWateringTasks(i, 'تقليل الري استعدادًا للحصاد.'),

      Tasks(
        id: 8,
        name: 'الحصاد',
        description: 'حصد الشعير عندما تجف السنابل وتتحول للون الذهبي.',
        day: 140,
      ),
    ],
    Duration_of_growth: '140 إلى 160 يومًا');

List<Tasks> generateWateringTasks(int startDay, String description) {
  return [
    Tasks(
      id: 9, // Ensures a unique ID for each task
      name: 'الري',
      description: description,
      day: startDay,
    ),
  ];
}
