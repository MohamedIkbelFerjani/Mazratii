import 'package:mazratii/Models/plantmodel.dart';
import '../Models/taskmodel.dart';

const int Germination_Stage =
    7; // Days between checks and care tasks in germination stage
const int Growth_Stage =
    10; // Days between checks and care tasks in growth stage
const int Flowering_Stage = 5; // Days during flowering
const int Fruiting_Stage = 3; // Days during fruit development and ripening

Plant myStrawberry = Plant(
    age: 0,
    id: 2,
    time: DateTime.now(),
    season: 'الربيع',
    water: 'متوسطة إلى مرتفعة',
    description:
        'تعتبر الفراولة من النباتات التي تنمو بشكل جيد في التربة الغنية بالمواد العضوية والتي تتميز بجيد التصريف. تحتاج إلى الشمس المباشرة لمدة 6-8 ساعات يوميًا. من المهم الحفاظ على رطوبة التربة دون إغراق.',
    spaceId: 125,
    plantName: 'نبتة الفراولة',
    image: 'myStrawberry.jpeg',
    tasks: [
      Tasks(
        id: 1,
        name: 'تحضير الأرض',
        description: 'حرث الأرض وإضافة السماد العضوي قبل زراعة الفراولة.',
        day: 1,
      ),
      Tasks(
        id: 2,
        name: 'زراعة البذور',
        description:
            'زرع البذور في صفوف بمسافات متباعدة لتوفير مساحة كافية للنمو.',
        day: 1,
      ),
      Tasks(
        id: 3,
        name: 'الري الأولي',
        description: 'سقي البذور بعد زراعتها مباشرة لتشجيع الإنبات.',
        day: 2,
      ),

      // Add repetitive tasks directly to the Tasks list within Plant object
      for (int i = 7; i <= 30; i += Germination_Stage)
        ...generateWeeklyTasks(i, 'تفقد الرطوبة والضوء للبادرات الصغيرة'),
      for (int i = 31; i <= 60; i += Growth_Stage)
        ...generateWeeklyTasks(i, 'التسميد والري المنتظم لدعم النمو القوي'),
      for (int i = 61; i <= 90; i += Flowering_Stage)
        ...generateWeeklyTasks(i, 'تفقد الزهور وتوفير دعم إضافي إذا لزم الأمر'),
      for (int i = 91; i <= 120; i += Fruiting_Stage)
        ...generateWeeklyTasks(i, 'رعاية الثمار والحفاظ على رطوبة التربة'),

      Tasks(
        id: 9,
        name: 'الحصاد',
        description: 'جمع الفراولة عندما تصبح حمراء بالكامل وناضجة.',
        day: 120,
      ),
    ],
    Duration_of_growth: '120 إلى 140 يومًا');

List<Tasks> generateWeeklyTasks(int startDay, String specificTask) {
  return [
    Tasks(
      id: 1, // Ensures a unique ID for each task
      name: 'الرعاية الدورية',
      description: specificTask,
      day: startDay,
    ),
  ];
}
