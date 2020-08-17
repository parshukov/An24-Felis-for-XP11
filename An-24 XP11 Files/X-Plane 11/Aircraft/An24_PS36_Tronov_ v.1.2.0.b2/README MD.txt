An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0
--------------------------------------------------------------------------

Адаптирована под X-Plane 11 Linux, Windows. Версия 1.2.0.
В Mac OS X самолет не проверялся, но работать должен. 

Установка
----------
Распаковать архив в корневую папку X-Plane

---------------------------------------------------------------------------------------------------------------------------
ВНИАНИЕ!!!! Для самостоятельной корректировки текстур кокпита и кабины приложены файлы int_salon.psd и int_flightdeck2.psd. 
---------------------------------------------------------------------------------------------------------------------------

Основана на базовой версии An24_Felis_open_src v.3.6 Parnik simulations.
Исправление визуальной модели начата в 2018 с году с An24_Felis_open_src v.3.5.7 Parnik simulations.

История версий:
1)  Выполнен полный ремап всех 3Д элементов продукта.
1)  База KLN 90B Navdata, размещающаяся в корне сима, приведена к нативному виду по состоянию на сентябрь 2019 года.
2)  исправлены KLN90_panel.lua. Теперь базы навиграфа после обновления либо штатной утилитой, либо вручную, не вызывают сбоев.
3)  Практически, все файлы obj подверглись ремапу, благодаря чему после настройки отражений 3Д модель была избавлена от шумов. Текстуры были взяты из оригинальной версии от Фелиса и чуточку подправлены. Текстуры в комплекте Н.Паршукова сильно затемнены, а светящиеся надписи передавлены. Файлы нормалей фактически были созданы заново. Убиралось и заменялось все, что нелогично, например, не может вокруг своей оси крутиться блик на штурвале. По этой причине, во избежание непредвиденного результата, все файлы из этой папки надо удалить. 
4)  Свет изначально был большой проблемой. Коля сделал стрелки светящимися в темное время суток. Это было нелогично: светящиеся стрелки на черных полях приборов. Для подсветки шкалок приборов был создан был новый obj файл, в котором вставлено около 80 с лишним ламп.  Так же, отныне подсвечены панели на оверхеде. Лампы старался разместить на своих местах в соответствии с моделью. Включаются тумблером освещение с места КВС. Этим же тумблером включается освещение рабочего стола штурмана. 
5)  Белые и красные светильники в кокпите были выделены в отдельный объект. Обусловлено это тем, что для отображения свечения ламп используется литтекстура, которая в свою очередь передавливает текстуры в кокпите. Из-за чего объекты в ночное время выглядят плоскими. 
6)  Чеклист переведен на русский язык. Добавлен профиль ТрекИРа для X-Camera.
7) Самолёт настроен в соответствии с уточненными данными из РЛЭ, уточнена логика автопилота. Огромнейшее спасибо за помощь Валере Рулеву. 
8) Заменены магнитный компас в кокпите, добавлен автоматический чеклист. 
9) План полета "Бориса" теперь отображает частоты маяков. 
10) Настроена панель загрузки и центровок. Исправлена работа триммера РВ. Спасибо за консультации Роману Сойко и Валере Рулёву.
11) Исправлен свет фар.
12) Лётная модель благодаря Валере Рулёву отныне 11.4X-ready. Не забудьте отключить экспериментальную модель полёта (хотя, я оставил ;-) ).
13) Исправлены шкала триммера руля высоты и подсветка надписей центральной панели. 
14) Сделано комбинированное 3Д-освещение кабины, кокпита и багажных отделений. Добавлены в кабину рабочие трехмерные светильники на место текстурных изображений. Реализованная в 1.1.11 версии подсветка внутри самолета разделена на регулярную, красную (кокпит и передний багажник) и белую дежурную.  Лит-текстуры работающих светильниках заменены эффектом свечения. С любезного разрешения JetManHuss (VSkyLabs) текстурное изображение огнетушителя в багажном отделении заменено на  трехмерную модель. По этой причине, изменена текстура int_salon.dds.
15) Ливреи проверены на работоспособность в линуксе и виндоус, заново созданы значки.
16) В меню возвращен пункт "Сервис". Теперь окно обслуживания вызывается не только по радио, но и из меню. Окно обслуживания, открытое через меню можно закрыть собственной клик-зоной. Через меню обслуживание теперь можно открыть/закрыть люк в кокпите. Вызов меню обслуживания набором частоты 131.80 на COM2 радио так же работает, тем самым функциональность меню обслуживания, введенная Parnik simulations сохранена.
17) Схемы освещения кабины, багажных отделений и кокпита переработаны. Вызвано это тем, что внутри выше названных помещений двери/люки остались неосвещенными. Это обусловлено тем, что данные объекты -- часть внешней модели, которая в темноте, естественно, не освещена. Поэтому, для подсветки каждого элемента была создана своя схема освещения.
18) Переработаны проблесковые маяки. В базовой версии, при наступлении темного времени суток литтекстурой была постоянно подсвечена область верхнего проблескового маяка. Литтекстура убрана, маяки работают правильно.  
19) Там где было это возможно, убраны литтекстуры, заменены параметрическим светом что позволило слить воедино ранее разделенные объекты. 
20) Внесено очень много исправлений, улучшающих атмосферу самолета, исправляющих некоторые ошибки, которые были выявлены за годы.эксплуатации этой модели. Добавлена озвучка к ранее неозвученным устройствам. Убран ФМОД, звуки самолета заменены звуками с реального самолета (огромное спасибо NO) за проделанную работу и Сергею МИНСУ за решение проблемы с часами АЧС-1).
21) В самолет дополнена озвучка систем. Решена старая проблема этой сборки, теперь для смены самолета не надо перегружать симулятор. Внесены изменения в летную модель (огромное спасибо Валере Рулёву за проделанную работу).
22) Добавлены трехмерные навигационные приборы. 

Если сделано все правильно, то Ан-24 РВ Фелиса в редакции Николая Паршукова и Ко будет радовать Вас еще долгое, долгое время. 

Удачных полетов!

Олег Тронов

Релиз       26 сентября 2019 г.
Обновлено   13.10.19
Обновлено   19.10.19
Обновлено   02.11.19
Обновлено   15.01.20
Обновлено   20.01.20
Обновлено   26.01.20
Обновлено   06.06.20
Обновлено   03.08.20

Финал       14.08.2020

PS Большое спасибо Андрею Felis за самолет, Коле Паршукову и Денису Полигешко за работу самолета в 11 версии X-Plane 11, Валере Рулеву за допил лётной модели, NO и Евгению Горбачёву за консультации, Лёне Кондрашову за оперативную помощь в работе над самолетом, Тодиру за плагин 3D KLN-90B и консультативную помощь во внедрении трехмерных приборов. 

PPS Это законченная версия. Обновления продукта в части локализации будут внесены позднее.
Наименование продукта: "An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0", далее Продукт
Продукт Opensource, GPL. Внимание, Лицензия GPL3 на этот Продукт не распространяется.
Использование данного Продукта или отдельных компонентов данного Продукта в сторонних продуктах/аддонах
без разрешения и согласования с автором Продукта -- Олегом Троновым, запрещено.

==========================================================================================================
Adapted for X-Plane 11 Linux, Windows.  Version upd 1.2.0.
On Mac OS X, the aircraft was not tested, but should work.


Install
----------
Unpack archive at the simulator root folder.

-----------------------------------------------------------------------------------------------------------------------
ATTENTION!!! int_salon.psd and int_flightdeck2.psd files added for self-edit of texture files.
-----------------------------------------------------------------------------------------------------------------------

Based on the basic version of An24_Felis_open_src v.3.6 Parnik simulations.
Visual model fix started in 2018 with An24_Felis_open_src v.3.5.7 Parnik simulations..

And so, what has been done:

1) Complete remap of all 3D elements of the product.
2) The base KLN 90B Navdata, located in the root of the sim, is brought to its native form as of September 2019.
3) fixed by KLN90_panel.lua. Now, the navigational database after updating either with the standard utility or manually does not cause failures.
4) Practically, all obj-files were remaped, thanks to which, after adjusting the 3D reflections, the model was spared noises. The textures were taken from the original version from Felis and a little tweaked. The textures in N. Parshukov’s set are greatly darkened, and the luminous inscriptions are transmitted. Normal files were actually recreated. Everything that was illogical was removed and replaced, for example, a glare at the yoke cannot spin around its axis. For this reason, to avoid unexpected results, all files from this folder must be deleted.
5) Light was originally a big problem. Nick made the arrows glow in the dark. It was illogical: the luminous arrows on the black fields of the instruments. To illuminate the instrument dials, a new obj file was created in which about 80-odd lamps were inserted. Also, the panels on the overhead are now highlighted. I tried to place the lamps in their places in accordance with the model. Turning on the toggle switch lighting from the pic. The same toggle switch turns on the lighting of the navigator's desktop.
6) The checklist has been translated into Russian (not relevant for the English version, but this is a translation from Russian. ). Added TrackIR profile for X-Camera. Checklist changed 19.10.2019.
7) The aircraft is configured in accordance with the updated data from the An-24 flight manual, the logic of the autopilot is refined. Thank you so much for helping Valera Rulev.
8) Magnetic compass added and autochecklist (need english translate, I see) changed.
9) "Boris" flight plane expose ADF beacons frequrency now.
10) The loading and centering panel is reconfigured. Elevator trim corrected. Thanks for the advice to Roman Soiko and Valera Rulev.
11) Landing and taxing lights corrected.
12) Many thanks to Valery Rulyov for the flight model ver. 11.4X ready. Don't forget to switch off experimental flight model.
m) Added night illumination of the An-24 cockpit when connected to airfield power. The elevator trimmer scale and central panel highlighting are fixed now.  
13) Made 3D lighting of the cabin. 3D working lights were added to the cockpit to replace texture images. The backlight inside the aircraft realized in 1.1.11 version is divided into regular, red (cockpit and front trunk) and white duty. The lit textures of the working fixtures are replaced by a glow effect. With the kind permission of JetManHuss (VSkyLabs), the texture image of the fire extinguisher in the luggage compartment has been replaced with a three-dimensional model. For this reason, the texture of int_salon.dds has been changed.
14) Liveries checked for serviceability in Linux and Windows, re-created icons.
15) The menu item "Service" is returned. Now the service window is called not only by radio, but also from the menu. The service window, opened through the menu, can be closed with its own click zone. Through the service menu, you can now open / close the hatch in the cockpit. Call dial service menu on frequency 131.80 COM2 radio is also working, thus the functionality of the service menu introduced Parnik simulations saved.
16) Cabin, luggage and cockpit lighting schemes have been redesigned. This is due to the fact that inside the above-mentioned rooms the doors / hatches remained unlit. This is due to the fact that these objects are part of the external model, which in the dark, of course, is not lit. Therefore, to illuminate each element, its own lighting scheme was created.
17) Reworked flashing beacons. In the basic version, at nightfall, the area of the upper flashing beacon was constantly lit with littexture. From now on, each flashing beacon turns on and off with its toggle switch on the AZS panel behind the co-pilot’s seat with the light texture turned off.
18) A lot of corrections have been made to improve the atmosphere of the aircraft, correcting some errors that have been identified over the years of operation of this model. Added sounds to previously silent devices. The FMOD has been removed, the sounds of the plane have been replaced by the sounds of a real plane (many thanks to NO) for the work done and Sergey MINS for solving the AChS-1 watch problem).
19) Some system soound added. Fixed an old problem of this build. If you want to change aeroplane you don't need restart simulator now. The flight model changed (many thanks to Valeriy Rulyov for it). Please use nonexperimental X-Plane flight model. 
20) 3D navigation devices added. 

If everything is done correctly, then the An-24 RV by Felis edited by Nikolai Parshukov and Co. will please you for a long, long time.

Have a nice flight!

Oleg Tronov, Sochi, Russia.

Released at 26-th of September, 2019
Updated 01.10.19
Updated 13.10.19
Updated 19.10.19
Updated 02.11.19
Updated 15.01.20
Updated 20.01.20
Updated 26.01.20
Updated 06.06.20
Updated 03.08.20

Finalised    at 14-th of August, 2020

PS Many thanks to Andrei Felis for this plane, Nickolay Parshukov and Denis Poligeshko for aircraft work in the X-Plane version 11, Valera Rulev for completing the flight model, NO and Yevgeny Gorbachev for consultations, and Leonid Kondrashov for prompt assistance in working on the plane.

PPS It finalised version. Updates of localisation parts will be soon. 
Product name: "An24_Felis_open_src v.3.6 Parnik simulations, Oleg Tronov update v.1.2.0", further Product
Opensource product, GPL. Attention, the GPL3 license does not apply to this Product.
Use of this Product or individual components of this Product in third-party products / add-ons
without permission and agreement with the author of the Product -- Oleg Tronov, is prohibited.


