# An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0
--------------------------------------------------------------------------

Большое спасибо Андрею Felis за самолет, Коле Паршукову и Денису Полигешко за работу самолета в 11 версии X-Plane 11, Валере Рулеву за допил лётной модели, NO и Евгению Горбачёву за консультации, Лёне Кондрашову за оперативную помощь в работе над самолетом, Тодиру за плагин 3D KLN-90B и консультативную помощь во внедрении трехмерных приборов. 

Адаптирована под X-Plane 11 Linux, Windows. Версия 1.2.0. Финал.
В Mac OS X самолет не проверялся, но работать должен. 

Установка
----------
Распаковать архив в корневую папку X-Plane [~/X-Plane-11, C:\X-Plane11].

---------------------------------------------------------------------------------------------------------------------------
ВНИАНИЕ!!!! Для самостоятельной корректировки текстур кокпита и кабины приложены файлы int_salon.psd и int_flightdeck2.psd. 
---------------------------------------------------------------------------------------------------------------------------

Основана на базовой версии An24_Felis_open_src v.3.6 Parnik simulations.

История:
1)  Выполнен полный ремап всех 3Д элементов фюзеляжа продукта.
1)  База KLN 90B Navdata, размещающаяся в корневой папке сима, приведена к нативному виду по состоянию на сентябрь 2019 года.
2)  Исправлен скрипт KLN90_panel.lua -- причина вылета симулятора в nix-системах.
3)  Выполнены полный ремап всех 3Д элементов кабины и кокпита, коррекция текстур, настройка PBR-отражений. 
4)  Создан obj-файл подсветки шкалок приборов с моделью на 80 ламп.  Выполнена подсветка оверхеда. Включаются тумблером освещение с места КВС. Этим же тумблером включается освещение рабочего стола штурмана. 
5)  Белые и красные светильники в кокпите были выделены в отдельный объект. 
6)  Создан автоматический чеклист переведен на русский язык. Добавлен профиль ТрекИРа для X-Camera.
7)  Самолёт настроен в соответствии с уточненными данными из РЛЭ, уточнена логика автопилота (спасибо В. Рулеву). 
8)  Заменены магнитный компас в кокпите. 
9)  Восстановлено отображение частот VOR, NDB  маяков в план полета "Бориса". 
10) Настроена панель загрузки и центровок. Исправлена работа триммера РВ. Спасибо за консультации NO и Валере Рулёву.
11) Исправлен свет фар.
12) Лётная модель автор 11.4X-ready (Валерий Рулёв). Экспериментальная модель полёта должна быть отключена.
13) Исправлены шкала триммера руля высоты и подсветка надписей центральной панели. 
14) Выполнено: комбинированное 3Д-освещение кабины, кокпита и багажных отделений; текстурные изображения светильникова заменены на трехмерные. Освещение кабины самолета разделено на регулярную, красную (кокпит и передний багажник) и белую дежурную. Текстурное изображение огнетушителя в багажном отделении заменено на трехмерную модель (спасибо JetManHuss (VSkyLabs)).
15) Ливреи в формате DDS проверены на работоспособность в линуксе и виндоус.
16) Возвращена возмжность управления пунктом "Сервис" из меню, как в оригинальной версии. Окно обслуживания вызывается и по радио, и из меню. Исправлена функция "открыть/закрыть люк" в меню "Сервис". Вызов меню обслуживания набором частоты 131.80 на COM2 радио так же работает, тем самым функциональность меню обслуживания, введенная Parnik simulations сохранена.
17) Схемы освещения кабины, багажных отделений и кокпита переработаны.
18) Переработаны проблесковые маяки. Литтекстура заменена параметрическим светом.  
19) Внесено очень много исправлений, улучшающих атмосферу самолета, исправляющих некоторые ошибки, которые были выявлены за годы.эксплуатации этой модели. Добавлена озвучка к ранее неозвученным устройствам. Убран ФМОД, звуки самолета заменены звуками с реального самолета (спасибо NO) за проделанную работу и Сергею МИНСУ за решение проблемы с часами АЧС-1).
20) В самолет дополнена озвучка систем. Решена старая проблема этой сборки, теперь для смены самолета не надо перегружать симулятор. Внесены изменения в летную модель (огромное спасибо Валере Рулёву за проделанную работу).
21) Добавлены трехмерные навигационные приборы. 

Удачных полетов!

Олег Тронов

Релиз       26 сентября 2019 г.

Финал       14 августа 2020 г.



PS Это законченная версия.
Наименование продукта: "An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0", далее Продукт.
Отказ от ответственности: Продукт Opensource. Автор не даёт никаких гарантий на Продукт и не несёт ответственности за проблемы, возникшие в результате его использования. 

==========================================================================================================

Adapted for X-Plane 11 Linux, Windows.  Version upd 1.2.0.
-------------------------------------------------------------

On Mac OS X, the aircraft was not tested, but should work.

Many thanks to Andrei Felis for this plane, Nickolay Parshukov and Denis Poligeshko for aircraft work in the X-Plane version 11, Valera Rulev for completing the flight model, NO and Yevgeny Gorbachev for consultations, and Leonid Kondrashov for prompt assistance in working on the plane.

Install
----------
Unpack archive at the simulator root folder  [~/X-Plane-11, C:\X-Plane11].

-----------------------------------------------------------------------------------------------------------------------
ATTENTION!!! int_salon.psd and int_flightdeck2.psd files added for self-edit of texture files.
-----------------------------------------------------------------------------------------------------------------------

Based on the basic version of An24_Felis_open_src v.3.6 Parnik simulations.
Visual model fix started in 2018 with An24_Felis_open_src v.3.5.7 Parnik simulations..

History:

1) Complete remap of all 3D elements of the product.
2) The KLN 90B Navdata database located in the root folder of the sim has been brought back to its native form as of September 2019.
3) Fixed the KLN90_panel.lua script - the reason for the simulator crash on nix systems.
4) Complete remapping of all 3D elements of the cockpit and cockpit, texture correction, setting of PBR reflections..
5) White and red cockpit lights have been separated into a separate object.
6) An automatic checklist has been created and translated into Russian. Added TrakIr profile for X-Camera.
7) The aircraft is tuned in accordance with the updated data from the Airplane Flight Manual, the autopilot logic has been refined (thanks to V. Rulev).
8) Replaced the magnetic compass in the cockpit.
9) The display of VOR and NDB beacon frequencies in the Boris flight plan has been restored.
10) The loading and centering panel has been adjusted. Fixed work of the elevator trimmer. Thanks for the advice NO and Valera Rulev.
11) Fixed headlights.
12) Flight model by 11.4X-ready (Valery Rulev). The experimental flight model should be disabled.
13) Fixed the elevator trimmer scale and the center panel lettering highlighting.
14) Completed: combined 3D lighting of the cockpit, cockpit and luggage compartments; the texture images of the luminaire are replaced with three-dimensional ones. The aircraft cockpit lighting is divided into regular, red (cockpit and front rack) and white on duty. The textured image of the fire extinguisher in the luggage compartment has been replaced with a 3D model (thanks to JetManHuss (VSkyLabs)).
15) Liveries in DDS format are tested for operability in Linux and Windows.
16) Returned the ability to manage the "Service" item from the menu, as in the original version. The service window is called both by radio and from the menu. Fixed the "open / close hatch" function in the "Service" menu. Calling the service menu by dialing the frequency 131.80 on the COM2 radio also works, thus the service menu functionality introduced by Parnik simulations is preserved.
17) Lighting schemes for the cockpit, luggage compartments and cockpit have been revised.
18) Reworked flashing beacons. Lite texture replaced with parametric light.
19) A lot of fixes have been made to improve the atmosphere of the aircraft, fixing some errors that have been identified over the years of operation of this model. Added voice acting to previously unvoiced devices. The FMOD was removed, the sounds of the aircraft were replaced by the sounds from a real aircraft (thanks to NO) for the work done and to Sergey MINS for solving the problem with the AChS-1 clock).
20) Added voice acting to the aircraft. The old problem of this assembly is solved, now you do not need to overload the simulator to change the aircraft. Changes have been made to the flight model (many thanks to Valera Rulev for the work done).
21) Added three-dimensional navigation devices.

Have a nice flight!

Oleg Tronov, Sochi, Russia.

Released at 26-th of September, 2019

Finalised    at 14-th of August, 2020

PS It finalised version. Updates of localisation parts may will be soon. 
Product name: "An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0", further Product
Opensource product. The author does not give any guarantees for the Product and is not responsible for problems arising from its use.
