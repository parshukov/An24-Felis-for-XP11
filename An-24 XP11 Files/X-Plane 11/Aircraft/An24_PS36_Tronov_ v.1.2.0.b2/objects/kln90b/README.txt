First before anything else – BACKUP EVERYTHING!

kln_installer - Automatic click regions merging
Add kln90b and md41(optional) objects to your cockpit via Plane Maker. Adjust positions and save file. Take note how exactly is panel.obj called.
Run kln_installer.exe. Chose acf file just saved by Plane Maker, and next chose panel.obj file. Program will look for kln90b and md41 objects in acf file and if found will print their positions
including offset from cocpit.obj. After that program will generate new file called "some_panel"_kln90b.obj located in /objects/kln90b folder. In plane maker change
original panel.obj with the newly created file. It may exist twice in misc objects. If so replace it in both places, do not change options. Save and fly.


Offset_calculator - manual method - preferred, safer

1.	First and main use is to calculate offsets for click_regions integration to 3d cockpit click regions. Open PlaneMaker and from Standard -> Misc Objects add kln90b and/or md41 object.
Move it to where you want on EMPTY space on the panel.  Chose Standard -> Viewpoint menu. Check if "edit in METRIC dimensions" box is checked, do not edit it. 
Changing to metric and vice versa may break other instruments positions.
Run offset_calculator.exe and on the first line input click regions file for parsing – example kln90b_click_regions.obj
If "edit in METRIC dimensions" is checked type “m” for meters, else type “f”.
X,Y and Z are values from Plane Maker alignment. As you see them in that order left to right. If object is not moved in PlaneMaker type 0-s.
If cocpit.obj has offset of its own you need to add or subtract that offset from kln90b/md41 values using reverse sign. For example if cocpit obj has -2.3 offset for X
you need to ADD 2.3 to kln90b X offset and if offset is 2.3 you need to subtact that value.
Same for angles X,Y and Z.
Open “plane_name”_cockpit.obj from plane main folder. Use notepad because other editors can break encoding and add additional hidden symbols. 
The first and last value on the POINT_COUNTS line correspond to IDX and TRIS offsets.
Example POINT_COUNTS 5205 0 0 18900
IDX 5205
TRIS 18900
File called offset.txt will be generated containing offset values
In cockpit.obj from aircraft main folder replace line POINT_COUNTS with the one from offset.txt. Copy everything down from that line in offset.txt, paste it at the bottom of cockpit.obj and save
Load your aircraft and enable “show instrument click regions” from view menu. Ensure that they align with object and look OK with no gaps and twists. 
Do not close x-plane, and open for edit cockpit.obj again. Do some cleanup – move the new VT section directly after original VT section end. 
Do the same for IDX section. Leave animations at the end. This is not mandatory but some performance gain may exist. Save file and from developers menu in x-plane chose “reload current aircraft and art”. 
If it is still OK you are done.
Repeat procedure for another object if needed. Offset.txt will be overwritten.

2.	Fine tune object positions.
Input file is the 3d object – example kln90b.obj
X,Y and Z as required. Values can be much finer than PlaneMaker allows
ODX and TRIS must be 0
IMPORTANT! Rotation is not supported for this mode. Any rotation will ommit object animations and leave them in their original positions!
Copy all from offset.txt and paste it in object file. Or simply rename offset.txt to “some name”.obj. The new object will have new 0 position.
Do it again with same values for corresponding click_regions.obj

Program has been tested on provided files only. It has no safeguards and will fail miserably if not used properly. User is responsible for everything.
The author is not responsible for the consequences of use of this software.
