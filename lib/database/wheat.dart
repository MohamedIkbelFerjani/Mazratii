import 'package:mazratii/Models/plantmodel.dart';
import '../Models/taskmodel.dart';

const int Germination_Stage =
    5; // Days between watering and checks in germination stage
const int Vegetative_Stage = 7; // Days between care tasks in vegetative stage
const int Tillering_Stage = 10; // Days between observations during tillering
const int Heading_Stage = 5; // Days during heading phase
const int Maturation_Stage = 10; // Days leading up to harvest

Plant myWheat = Plant(
    age: 0,
    id: 4,
    time: DateTime.now(),
    season: 'الخريف',
    water: 'متوسطة',
    description:
        'القمح من النباتات التي تتطلب تربة جيدة التصريف ومعرضة للشمس الكاملة. يجب زراعته في تربة تم تحضيرها جيدًا ومعدلة بالأسمدة العضوية. القمح متين ويمكنه تحمل البرودة إلى حد ما.',
    spaceId: 127,
    plantName: 'نبتة القمح',
    image: 'wheat.jpeg',
    tasks: [
      Tasks(
        id: 1,
        name: 'تحضير الأرض وزراعة البذور',
        description: 'حرث الأرض وزراعة بذور القمح بعمق حوالي 2-3 سنتيمترات.',
        day: 1,
      ),
      Tasks(
        id: 2,
        name: 'الري الأولي',
        description: 'ري البذور بعد زراعتها مباشرة لتعزيز الإنبات.',
        day: 2,
      ),

      // Repetitive watering and care tasks during critical stages
      for (int i = 3; i <= 25; i += Germination_Stage)
        ...generateWateringTasks(
            i, 'الحفاظ على رطوبة التربة دون تشبع لتعزيز الإنبات.'),
      for (int i = 26; i <= 85; i += Vegetative_Stage)
        ...generateWateringTasks(i, 'تأكد من رطوبة التربة خلال النمو الخضري.'),
      for (int i = 86; i <= 135; i += Tillering_Stage)
        ...generateWateringTasks(
            i, 'رصد النباتات وضبط الري حسب الحاجة خلال فترة التفريع.'),
      for (int i = 136; i <= 160; i += Heading_Stage)
        ...generateWateringTasks(
            i, 'توفير الماء بشكل متوازن خلال مرحلة النمو الرئيسية.'),
      for (int i = 161; i <= 180; i += Maturation_Stage)
        ...generateWateringTasks(i, 'تقليل الري استعدادًا للحصاد.'),

      Tasks(
        id: 9,
        name: 'الحصاد',
        description: 'حصد القمح عندما تجف السنابل وتتحول للون الذهبي.',
        day: 180,
      ),
    ],
    Duration_of_growth: '180 إلى 200 يومًا');

List<Tasks> generateWateringTasks(int startDay, String description) {
  return [
    Tasks(
      id: 10,
      name: 'الري',
      description: description,
      day: startDay,
    ),
  ];
}
