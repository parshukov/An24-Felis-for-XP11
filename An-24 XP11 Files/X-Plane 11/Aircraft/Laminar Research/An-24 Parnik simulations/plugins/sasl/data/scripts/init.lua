-- list of path to search components
searchPath = { ".", "" }

-- list of path to search images
searchImagePath = { ".", "" }

-- show areas on which clicking is possible
showClickableAreas = false

-- saved panelsPositions
panelsPositions = nil

-- returns true if argument is property
function isProperty(value)
    return ("table" == type(value)) and (1 == value.__property)
end


-- consider 0 as false
function toboolean(value)
    if 0 == value then
        return false
    else
        return value
    end
end


-- load stands from cache
function loadTableFromFile(fileName, name)
    local chunk = loadfile(fileName)
    if nil ~= chunk then
        local t = { }
        setfenv(chunk, t)
        chunk()
        return t[name]
    else
        logError('file not exists', fileName)
        return nil
    end
end


-- save table to file
local function saveTableToFile(f, table, name)
    if name then
        f:write(name .. ' = ')
    end
    f:write('{\n')

    for k, v in pairs(table) do
        f:write('["' .. k .. '"] = ')
        if ('number' == type(v)) or ('boolean' == type(v)) then
            f:write(tostring(v) .. ';\n')
        elseif ('string' == type(v)) then
            f:write('"' .. v .. '";\n')
        elseif ('table' == type(v)) then
            saveTableToFile(f, v)
        end
    end

    f:write('};\n')
end

-- save table to file
local function savePositionsToFile(f, table, name)
    if name then
        f:write(name .. ' = ')
    end
    f:write('{\n')

    for k, v in pairs(table) do
        f:write('["' .. k .. '"] = { ')
        for i = 1, 4 do
            f:write(v[i])
            if 4 ~= i then
                f:write(', ')
            else
                f:write(' ')
            end
        end
        f:write('};\n')
    end

    f:write('};\n')
end




-- create new property table
function createProperty(value)
    if isProperty(value) then
        return value
    end

    local prop = { __property = 1 }
    if "function" == type(value) then
        prop.get = value
    else
        prop.value = value
    end
    return prop
end


-- default mouse click handler
function defaultOnMouseClick(comp, x, y, button, parentX, parentY)
    if (1 == button) and get(comp.movable) and (1 == comp.dragging) then
        local position = get(comp.position)
        comp.dragStartX = parentX
        comp.dragStartY = parentY
        comp.dragStartPosX = position[1]
        comp.dragStartPosY = position[2]
        comp.dragging = 2
        return true
    end
    return false
end


-- default mouse down handler
function defaultOnMouseDown(comp, x, y, button, parentX, parentY)
    if (1 == button) and get(comp.resizeble) and 
                isInRect(comp.resizeRect, x, y) 
    then
        local pos = get(comp.position)
        comp.resizing = true;
        comp.dragStartX = parentX
        comp.dragStartY = parentY
        comp.dragStartPosX = pos[1]
        comp.dragStartPosY = pos[2]
        comp.dragStartSizeX = pos[3]
        comp.dragStartSizeY = pos[4]
        return true
    end

    if (1 == button) and get(comp.movable) then
        comp.dragging = 1
        return true
    end
    return false
end


-- default mouse up handler
function defaultOnMouseUp(comp, x, y, button, parentX, parentY)
    if 1 == button and (get(comp.movable) or get(comp.resizeble)) then
        if comp.dragging then
            comp.dragging = 0
        end
        if get(comp.resizeble) and comp.resizing then
            comp.resizing = false
        end
        return true
    end
    return false
end


-- default mouse move handler
function defaultOnMouseMove(comp, x, y, button, parentX, parentY)
    if (rawget(comp, "resizing")) then
        local pos = get(comp.position)
        local newSizeX = comp.dragStartSizeX + (parentX - comp.dragStartX)
        local newSizeY = comp.dragStartSizeY - (parentY - comp.dragStartY)

        if 10 > newSizeX then
            newSizeX = 10
        end
        if 10 > newSizeY then
            newSizeY = 10
        end

        if toboolean(get(comp.resizeProportional)) then
            ratio =  comp.dragStartSizeX / comp.dragStartSizeY
            propHeight = newSizeX / ratio;
            propWidth = newSizeY * ratio;
            if propHeight > newSizeY then
                newSizeY = propHeight
            else
                newSizeX = propWidth
            end
        end

        pos[2] = comp.dragStartY - (newSizeY - comp.dragStartSizeY)
        pos[3] = newSizeX
        pos[4] = newSizeY
        set(comp.position, pos)
        return true
    end

    if (2 == rawget(comp, "dragging")) and get(comp.movable) then
        local position = get(comp.position)
        position[1] = comp.dragStartPosX + (parentX - comp.dragStartX)
        position[2] = comp.dragStartPosY + (parentY - comp.dragStartY)
        set(comp.position, position)
        return true
    else
        return false
    end
end



-- default mouse wheel handler
function defaultOnMouseWheel(comp, x, y, button, parentX, parentY)
	
end

-- default key down handler
function defaultOnKeyDown(comp, char, key)
    return false
end

-- default key up handler
function defaultOnKeyUp(comp, char, key)
    return false
end


-- create basic component
function createComponent(name, parent)
    local data = { 
        components = { },
        componentsByName = { },
        size = { 100, 100 },
        position = createProperty { 0, 0, 100, 100 },
        mask = createProperty(false),
		renderTarget = -1,
		fpslimit = createProperty(-1),
		frames = 0,
		noRenderSignal = false,
		clip = createProperty(false),
		clip_size = createProperty { 0, 0, 0, 0 },
        draw = function (comp) drawAll(comp.components); end,
        update = function (comp) updateAll(comp.components); end,
        name = name,
        visible = createProperty(true),
        movable = createProperty(false),
        resizeble = createProperty(false),
        focused = createProperty(false),
        savePosition = createProperty(false),
        resizeProportional = createProperty(true),
        onMouseUp = defaultOnMouseUp,
        onMouseDown = defaultOnMouseDown,
        onMouseClick = defaultOnMouseClick,
        onMouseMove = defaultOnMouseMove,
		onMouseWheel = defaultOnMouseWheel,
        onKeyDown = defaultOnKeyDown,
        onKeyUp = defaultOnKeyUp,
	logInfo = function(...) logInfo('"' .. name .. '"', ...); end,
	logError = function(...) logError('"' .. name .. '"', ...); end,
	logDebug = function(...) logDebug('"' .. name .. '"', ...); end,
	logWarning = function(...) logWarning('"' .. name .. '"', ...); end,
	print = function(...) print('"' .. name .. '"', ...); end,
    }
    data._C = data
    if parent then
        data._P = parent
    end
    addComponentFunc(data)
    return data
end


-- create component function
function addComponentFunc(component)
    component.component = function(name, tbl)
        if not tbl then -- anonymous subcomponent
            tbl = name
            name = nil
        end
        table.insert(component.components, tbl)
        if name then
            component.componentsByName[name] = tbl
        end
        return tbl
    end
end


-- add component to popup layer
function popup(name, tbl)
    return popups.component(name, tbl)
end


-- main panel
panel = createComponent("panel")

-- popups layer
popups = createComponent("popups", panel)


-- returns simulator double property
function globalPropertyd(name, default)
    local ref = findProp(name, "double")
    return {
        __property = 1;
        get = function() return getPropd(ref, default); end;
        set = function(self, value) setPropd(ref, value); end;
    }
end

-- create new double property and set default value
function createGlobalPropertyd(name, default, notPublishInDRE)    
	if notPublishInDRE == nil then notPublishInDRE = 0 end
	local ref = createProp(name, 'double', default, notPublishInDRE, false)
    return globalPropertyd(name, default)
end

-- create new global functional double property
function createFuncPropertyd(name, getter, setter)
    local ref = createFuncProp(name, 'double', getter, setter)
    return globalPropertyd(name)
end


-- returns simulator float property
function globalPropertyf(name, default)
    local ref = findProp(name, "float")
    return {
        __property = 1;
        get = function() return getPropf(ref, default); end;
        set = function(self, value) setPropf(ref, value); end;
    }
end

-- create new float property and set default value
function createGlobalPropertyf(name, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'float', default, notPublishInDRE, false)
    return globalPropertyf(name, default)
end

-- create new global functional float property
function createFuncPropertyf(name, getter, setter)
    local ref = createFuncProp(name, 'float', getter, setter)
    return globalPropertyf(name)
end


-- returns simulator int property
function globalPropertyi(name, default)
    local ref = findProp(name, "int")
    return {
        __property = 1;
        get = function(doNotCall) return getPropi(ref, default); end;
        set = function(self, value) setPropi(ref, value); end;
    }
end

-- create new float property and set default value
function createGlobalPropertyi(name, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'int', default, notPublishInDRE, false)
    return globalPropertyi(name, default)
end

-- create new global functional int property
function createFuncPropertyi(name, getter, setter)
    local ref = createFuncProp(name, 'int', getter, setter)
    return globalPropertyi(name)
end

-- returns simulator string property
function globalPropertys(name, default)
    local ref = findProp(name, "string")
    return {
        __property = 1;
        get = function(doNotCall) return getProps(ref, default); end;
        set = function(self, value) setProps(ref, value); end;
    }
end

-- create new string property and set default value
function createGlobalPropertys(name, maxLen, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'string', maxLen, default, notPublishInDRE, false)
    return globalPropertys(name, default)
end

-- create new global functional string property
function createFuncPropertys(name, getter, setter, maxSize)
    local ref = createFuncProp(name, 'string', getter, setter, maxSize)
    return globalPropertys(name)
end

-- create new shared double property and set default value
function createGlobalSharedReferenced(name, default, notPublishInDRE)    
	if notPublishInDRE == nil then notPublishInDRE = 0 end
	local ref = createProp(name, 'double', default, notPublishInDRE, true)
    return globalPropertyd(name, default)
end

-- create new shared float property and set default value
function createGlobalSharedReferencef(name, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'float', default, notPublishInDRE, true)
    return globalPropertyf(name, default)
end

-- create new shared int property and set default value
function createGlobalSharedReferencei(name, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'int', default, notPublishInDRE, true)
    return globalPropertyi(name, default)
end

-- create new shared string property and set default value
function createGlobalSharedReferences(name, maxLen, default, notPublishInDRE)
	if notPublishInDRE == nil then notPublishInDRE = 0 end
    local ref = createProp(name, 'string', maxLen, default, notPublishInDRE, true)
    return globalPropertys(name, default)
end

-- returns value of property
-- traverse recursive properties
function get(property, doNotCall)
    if isProperty(property) then
        if property.get then
            return property:get(doNotCall)
        else
            if isProperty(property.value) then
                return get(property.value, doNotCall)
            else
                return property.value
            end
        end
    else
        if (not doNotCall) and ("function" == type(property)) then
            return property()
        else
            return property
        end
    end
end


-- set value of property
function set(property, value)
    if property.set then
        property:set(value)
    else
        if isProperty(property.value) then
            set(property.value, value)
        else
            property.value = value
        end
    end
end


-- deep copies values from source table to destination table
function mergeTables(dest, src)
    for k, v in pairs(src) do
        if "table" == type(v) then
            if not dest[k] then
                --dest[k] = { }
                dest[k] = v
            else
                mergeTables(dest[k], v)
            end
        else
            dest[k] = v
        end
    end
end


-- convert values from table to properties
function argumentsToProperties(arguments)
    local res = { }
    for k, v in pairs(arguments) do
        if "function" == type(v) then
            res[k] = v
        else
            if isProperty(v) then
                res[k] = v
            else
                res[k] = createProperty(v)
            end
        end
    end
    return res
end

-- update component
function updateComponent(v)
    if v and v.update then
        v:update()
    end
end

-- update all components from table
function updateAll(table)
    for _, v in pairs(table) do
        updateComponent(v)
    end
end

-- draw to component render target
function renderToTarget(v) 
	setRenderTarget(v.renderTarget, 1)
	v:draw()
	restoreRenderTarget()
end

-- draw component
function drawComponent(v)
    if v and toboolean(get(v.visible)) then
        saveGraphicsContext()
        local renderTargetExist = toboolean(get(v.mask))
        if renderTargetExist then
			if not v.noRenderSignal then
				local cur_fps = 1.0 / get(globalPropertyf("sim/operation/misc/frame_rate_period"))
				local limit = get(v.fpslimit)
				if limit == -1 or limit >= cur_fps then
					renderToTarget(v)
					v.frames = 0
				else 
					if v.frames > cur_fps / limit then
						renderToTarget(v)
						v.frames = 0
					else 
						v.frames = v.frames + 1
					end
				end
			end
			local pos = get(v.position)
			setTranslation(pos[1], pos[2], pos[3], pos[4], v.size[1], v.size[2])
			drawRenderTarget(v.renderTarget, 0, 0, v.size[1], v.size[2], 1, 1, 1, 1)
			v.noRenderSignal = false
        else
			local pos = get(v.position)
			setTranslation(pos[1], pos[2], pos[3], pos[4], v.size[1], v.size[2])
			local clip = toboolean(get(v.clip))
			local cs = get(v.clip_size) and get(v.clip_size) or {pos[1], pos[2], pos[1]+pos[3], pos[2]+pos[4]}			
			local clip_size = cs[3] > 0 and cs[4] > 0
			if clip then				
				if clip_size then					
					setClipArea(cs[1],cs[2],cs[3],cs[4])				
				else
					setClipArea(0, 0, v.size[1], v.size[2])
				end
			end
			v:draw()
			if clip then
				resetClipArea()
			end
		end 
		restoreGraphicsContext()
    end
end

-- draw all components from table
function drawAll(table)
    for _, v in pairs(table) do
        drawComponent(v)
    end
end

-- try to find key in local table first.
-- look in global table if key doesn't exists in local table
-- try to load component from file if it doesn't exists in global table
function compIndex(table, key)
    local comp = table
    while nil ~= comp do
        local v = rawget(comp, key)
        if nil ~= v then 
            return v 
        else
            comp = rawget(comp, '_P')
        end
    end

    v = _G[key]
    if nil == v then
        return loadComponent(key)
    else
        return v
    end
end

-- return true if file exists
function isFileExists(fileName)
    local f = io.open(fileName)
    if nil == f then
        return false
    else
        io.close(f)
        return true
    end
end


-- remove extension from file name
function extractFileName(filePath)
    for i = string.len(filePath), 1, -1 do
        if string.sub(filePath, i, i) == '.' then
            return string.sub(filePath, 1, i-1)
        end
    end
    return filePath
end


-- try to find file on search paths
function openFile(fileName)
    local name = extractFileName(fileName)

    for _, v in ipairs(searchPath) do
        local fullName
        local subdir
        if 0 < string.len(v) then
            fullName = v .. '/' .. fileName
            subdir = v .. '/' .. name
        else
            fullName = fileName
            subdir = name
        end

        -- check if it is available at current path
        if isFileExists(fullName) then
            local f, errorMsg = loadfile(fullName)
            if f then
                return f
            else
                logError(errorMsg)
            end
        end

        -- check subdir
        local subFullName = subdir .. '/' .. fileName
        if isFileExists(subFullName) then
            local f, errorMsg = loadfile(subFullName)
            if f then
                return f, subdir
            else
                logError(errorMsg)
            end
        end
    end

    return nil
end


 -- make deep copy of table
function cloneTable(table)
    local newTable = {}
    for k, v in pairs(table) do
        if "table" == type(v) then
            newTable[k] = cloneTable(v)
        else
            newTable[k] = v
        end
    end
    return newTable
end


-- add properties to component
function setupComponent(component, args)
    mergeTables(component, argumentsToProperties(args))
    setmetatable(component, { __index = compIndex })
    
    component.defineProperty = function(name, dflt)
        if not rawget(component, name) then
            component[name] = createProperty(dflt)
        end
    end

    component.include = function(name)
        include(component, name)
    end

    addComponentFunc(component)
end

local creatingComponents = { }


-- call it before creation of components
function startComponentsCreation(parent)
    table.insert(creatingComponents, parent)
end

-- call it after creation of components
function finishComponentsCreation()
    table.remove(creatingComponents)
end


-- load component from file and create constructor
function loadComponent(name, fileName)
    logInfo("loading", name)

    if not fileName then
        fileName = name .. ".lua"
    end

    local f, subdir = openFile(fileName)
    if not f then
        logError("can't load component", name)
        return nil
    end

    local constr = function(args)
        local parent = creatingComponents[#creatingComponents]
        if subdir then
            addSearchPath(subdir)
        end
        local t = createComponent(name, parent)
        t.componentFileName = fileName

        -- ugly hack to solve popups parent problem
        if ('panel' == name) and (nil == parent) then
            popups._P = t
        end

        setupComponent(t, args)
        startComponentsCreation(t)
        setfenv(f, t)
        f()
        finishComponentsCreation()
		
		if get(t.fpslimit) ~= -1 then
			set(t.mask, true)
		end
		
		if toboolean(get(t.mask)) then
			t.renderTarget = getNewRenderTargetID(t.size[1], t.size[2])
		end
		
        if subdir then
            popSearchPath()
        end
        return t
    end

    _G[name] = constr

    return constr
end


function resizePanel(width, height)
    set(panel.position, { 0, 0, width, height })
end

function resizePopup(width, height)
    set(popups.position, { 0, 0, width, height })
    popups.size[1] = width
    popups.size[2] = height
end


-- load panel from file
-- panel table will be stored in panel global variable
function loadPanel(fileName, panelWidth, panelHeight, popupWidth, popupHeight)
    popups = createComponent("popups")
    popups.position = createProperty { 0, 0, popupWidth, popupHeight }
    popups.size = { popupWidth, popupHeight }

    panelsPositions = loadTableFromFile(panelDir .. '/panels.txt', 'positions')

    local c = loadComponent("panel", fileName)
    if not c then
        logError("Error loading panel", fileName)
        return nil
    end
    panel = c({position = { 0, 0, panelWidth, panelHeight}})

    return panel
end


-- add path to search path
function addSearchPath(path)
    table.insert(searchPath, 1, path)
    table.insert(searchImagePath, 1, path)
end


function popSearchPath()
    table.remove(searchPath, 1)
    table.remove(searchImagePath, 1)
end


-- add path to images search path
function addSearchImagePath(path)
    table.insert(searchImagePath, 1, path)
end


-- cursor texture and position
cursor = {
    x = 0,
    y = 0,
    shape = nil
}


-- Draw panel on screen
function drawPanelLayer()
    drawComponent(panel)
end


-- draw popup panels
function drawPopupsLayer()
    drawComponent(popups)

    if cursor.shape then
        drawCursor()
    end
end


-- draw panel and popups layers
function drawPanel()
    drawPanelLayer()
    drawPopupsLayer()
end

-- update all component
function update()
    updateComponent(panel)
    updateComponent(popups)
end

function logErrorStacktrace(...)
	logError(...)
	local currentLevel = 3
	while true do
        local errorInfo = debug.getinfo(currentLevel, "Sl")
        if not errorInfo or errorInfo.what == "C" then break end
        logError(string.format("Stack trace [%s]:%d", errorInfo.short_src, errorInfo.currentline))
        currentLevel = currentLevel + 1
		if currentLevel > 5 then break end
     end
end

-- load texture image
-- loads image and sets texture coords.  It can be called in forms of:
-- loadImage(fileName) -- sets texture coords to entire texture
-- loadImage(fileName, width, height) -- sets texture coords to show 
--    center part of image.  width and height sets size of image part
-- loadImage(fileName, x, y, width, height) - loads specified part of image
function loadImage(fileName, x, y, width, height)
    for _, v in ipairs(searchImagePath) do
        local t = getGLTexture(v .. '/' .. fileName, x, y, width, height)
        if t then
            return t
        end
    end

    local tex = getGLTexture(fileName, x, y, width, height)
    if not tex then
        logErrorStacktrace("Can't load texture", fileName)
    end
    return tex
end


-- load font
function loadFont(fileName)
    for _, v in ipairs(searchImagePath) do
        local t = getGLFont(v .. '/' .. fileName)
        if t then
            return t
        end
    end

    local font = getGLFont(fileName)
    if not font then
        logErrorStacktrace("Can't load font", fileName)
    end
    return tex
end


-- check if coord lay inside rectangle.  rectangle is array of 
-- { x, y, width, height }
function isInRect(rect, x, y)
    local x1 = rect[1]
    local y1 = rect[2]
    local x2 = x1 + rect[3]
    local y2 = y1 + rect[4]
    return (x1 <= x) and (x2 > x) and (y1 <= y) and (y2 > y)
end

-- run handler of component
function runComponentHandler(component, name, mx, my, button, x, y, value)
    local handler = rawget(component, name)
    if handler then
        return handler(component, mx, my, button, x, y, value)
    else
        return false
    end
end


-- traverse components and finds best handler with specified name
function runHandler(component, name, x, y, button, path, value)
    local position = get(component.position)
    local size = component.size
    if (not (position and size)) then
        return false
    end
    local mx = (x - position[1]) * size[1] / position[3]
    local my = (y - position[2]) * size[2] / position[4]
    for i = #component.components, 1, -1 do
        local v = component.components[i]
        if toboolean(get(v.visible)) and isInRect(get(v.position), mx, my) then
            local res = runHandler(v, name, mx, my, button, path, value)
            if res then
                if path then
                    table.insert(path, component)
                end
                return true
            end
        end
    end
    local res = runComponentHandler(component, name, mx, my, button, x, y, value)
    if res then
        if path then
            table.insert(path, component)
        end
    end
    return res
end

-- returns path to component under mouse
function getFocusedPath(component, x, y, path)
    table.insert(path, component)
    local position = get(component.position)
    local size = component.size
    if (not (position and size)) then
        return
    end
    local mx = (x - position[1]) * size[1] / position[3]
    local my = (y - position[2]) * size[2] / position[4]
    for i = #component.components, 1, -1 do
        local v = component.components[i]
        if toboolean(get(v.visible)) and isInRect(get(v.position), mx, my) then
            getFocusedPath(v, mx, my, path)
        end
    end
end


-- returns path to component under mouse
function getTopFocusedPath(layer, x, y)
    local path = { }
    if (1 == layer) or (3 == layer) then
        getFocusedPath(popups, x, y, path)
        if 1 < #path then
            return path
        end
        path = { }
    end
    if (2 == layer) or (3 == layer) then
        getFocusedPath(panel, x, y, path)
    end
    return path
end


-- run handler of pressed component
function runPressedHandler(path, name, x, y, button, value)
    local mx = x
    local my = y
    local px = x
    local py = y
    for i = #path, 1, -1 do
        local c = path[i]
        px = mx
        py = my
        local position = get(c.position)
        local size = get(c.size)
        mx = (mx - position[1]) * c.size[1] / position[3]
        my = (my - position[2]) * c.size[2] / position[4]
    end
    return runComponentHandler(path[1], name, mx, my, button, px, py, value)
end


-- traverse components and finds best handler with specified name
function runTopHandler(layer, name, x, y, button, value)
    local path = { }
    if (1 == layer) or (3 == layer) then
        local res = runHandler(popups, name, x, y, button, path, value)
        if res then
            return true, path
        end
    end
    if (2 == layer) or (3 == layer) then
        return runHandler(panel, name, x, y, button, path, value), path
    end
end

-- returns value of cursor property for specified layer
function getTopCursorShape(layer, x, y)
    if (1 == layer) or (3 == layer) then
        local cursor = getCursorShape(popups, x, y)
        if cursor then
            return cursor
        end
    end
    if (2 == layer) or (3 == layer) then
        return getCursorShape(panel, x, y)
    end
end

-- returns value of cursor property
function getCursorShape(component, x, y)
    local position = get(component.position)
    local size = component.size
    if (not (position and size)) then
        return nil
    end
    local mx = (x - position[1]) * size[1] / position[3]
    local my = (y - position[2]) * size[2] / position[4]
    for i = #component.components, 1, -1 do
        local v = component.components[i]
        if toboolean(get(v.visible)) and isInRect(get(v.position), mx, my) then
            local res = getCursorShape(v, mx, my)
            if res then
                return res
            end
        end
    end
    return rawget(component, "cursor")
end

-- set shape of cursor
function setCursor(x, y, shape, layer)
    if (2 ~= layer) then
        cursor.x = x
        cursor.y = y
    end
    cursor.shape = get(shape)
end


-- draw cursor shape
function drawCursor()
    if cursor.shape and cursor.shape.shape then
        drawTexture(cursor.shape.shape, 
                cursor.shape.x + cursor.x, cursor.y - cursor.shape.y,
                cursor.shape.width, cursor.shape.height,
                1, 1, 1, 1)
    end
end


-- pressed button number
local pressedButton = 0

-- path to component after mouse press
local pressedComponentPath = nil

-- update pressed component path
function setPressedPath(path)
    pressedComponentPath = path
end

-- path to focused component
local focusedComponentPath = nil


-- update focused component path
function setFocusedPath(path)
    if path and (0 == #path) then
        path = nil
    end
    if focusedComponentPath then
        for _, c in pairs(focusedComponentPath) do
            set(c.focused, false)
        end
    end
    focusedComponentPath = path
    if focusedComponentPath then
        for _, c in ipairs(focusedComponentPath) do
            set(c.focused, true)
        end
    end
end

-- Called when mouse button was pressed
function onMouseDown(x, y, button, layer)
    setFocusedPath(getTopFocusedPath(layer, x, y))
    pressedButton = button
    local handled, path = runTopHandler(layer, "onMouseDown", x, y, button)
    if handled then
        setPressedPath(path)
        if (1 == layer) or (3 == layer) then
            local comp = path[1]
            for i, v in pairs(popups.components) do
                if v == comp then
                    table.remove(popups.components, i)
                    table.insert(popups.components, comp)
                    setPressedPath(nil)
                    return handled
                end
            end
        end
    end
    return handled
end


-- Called when mouse button was released
function onMouseUp(x, y, button, layer)
    if pressedComponentPath then
        local res = runPressedHandler(pressedComponentPath, "onMouseUp", 
                x, y, button)
        pressedButton = 0
        setPressedPath(nil)
        return res
    else
        return runTopHandler(layer, "onMouseUp", x, y, button)
    end
end

-- Called when mouse click event was processed
function onMouseClick(x, y, button, layer)
    if pressedComponentPath then
        setCursor(x, y, cursor.shape, layer)
        return runPressedHandler(pressedComponentPath, "onMouseClick", 
                x, y, button)
    else
        pressedButton = button
        local handled, path = runTopHandler(layer, "onMouseClick", x, y, button)
        if handled then
            setPressedPath(path)
        end
        return handled
    end
end

-- Called when mouse motion event was processed
function onMouseMove(x, y, layer)
    local cursorArrow = false
    if pressedComponentPath then
        cursorArrow = true
    else
        if ((1 == layer) or (3 == layer)) and 0 < #popups.components then
            local size = popups.size
            local position = get(popups.position)
            local mx = (x - position[1]) * size[1] / position[3]
            local my = (y - position[2]) * size[2] / position[4]
            for i = #popups.components, 1, -1 do
                local v = popups.components[i]
                if toboolean(get(v.visible)) and 
                        isInRect(get(v.position), mx, my) 
                then
                    cursorArrow = true
                    break
                end
            end
        end
    end
    if pressedComponentPath then
        setCursor(x, y, cursor.shape, layer)
        local res = runPressedHandler(pressedComponentPath, "onMouseMove", 
                x, y, pressedButton)
    else
        local cursor = getTopCursorShape(layer, x, y)
        setCursor(x, y, cursor, layer)
        local res = runTopHandler(layer, "onMouseMove", x, y, pressedButton)
    end
    return cursorArrow
end

-- Called when mouse wheel event was processed
function onMouseWheel(x, y, wheelClicks, layer)
	 if pressedComponentPath then
        local res = runPressedHandler(pressedComponentPath, "onMouseWheel", 
                x, y, 4, wheelClicks)
        return res
    else
        return runTopHandler(layer, "onMouseWheel", x, y, 4, wheelClicks)
    end
end

-- move panel to top of screen
function movePanelToTop(panel)
    for i, v in pairs(popups.components) do
        if v == panel then
            table.remove(popups.components, i)
            table.insert(popups.components, panel)
            return
        end
    end
end


-- create popup movable resizable subpanel hidden by default
function subpanel(tbl)
    local name = tbl.name
    if nil == name then
        name = 'subanel'
    end
    local c = createComponent(name, popups)
    set(c.position, tbl.position)
	set(c.clip, tbl.clip)
	set(c.clip_size, tbl.clip_size)
    set(c.mask, tbl.mask)
    c.size = { tbl.position[3], tbl.position[4] }
    c.onMouseClick = function (comp, x, y, button, parentX, parentY)
        defaultOnMouseClick(comp, x, y, button, parentX, parentY)
        return true
    end
    c.onMouseDown = function (comp, x, y, button, parentX, parentY)
        defaultOnMouseDown(comp, x, y, button, parentX, parentY)
        return true
    end
    c.onMouseMove = function (comp, x, y, button, parentX, parentY)
        defaultOnMouseMove(comp, x, y, button, parentX, parentY)
        return true
    end
    set(c.visible, false)
    set(c.movable, true)
    if get(tbl.noMove) then
        set(c.movable, false)
    end
    if get(tbl.savePosition) then
        set(c.savePosition, true);
    end
    c.cursor = { x = 0; y = 0; shape = loadImage("none.png") }
    c.components = tbl.components

    startComponentsCreation(tbl)
    if not get(tbl.noBackground) then
        if not rectangle then
            rectangle = loadComponent('rectangle')
        end
    
        table.insert(c.components, 1,
            rectangle { position = { 0, 0, c.size[1], c.size[2] } } )
    end

    if not get(tbl.noClose) then
        local pos = get(c.position)
        local btnWidth = c.size[1] / pos[3] * 16
        local btnHeight = c.size[2] / pos[4] * 16

        if not button then
            button = loadComponent('button')
        end

        c.component('closeButton', button { 
            position = { c.size[1] - btnWidth, c.size[2] - btnHeight, 
                btnWidth, btnHeight };
            image = loadImage('close.png');
            onMouseClick = function()
                set(c.visible, false)
                return true
            end;
        })
    end

    if not get(tbl.noResize) then
        set(c.resizeble, true)
        local pos = get(c.position)
        c.resizeWidth = c.size[1] / pos[3] * 10
        c.resizeHeight = c.size[2] / pos[4] * 10
        
        if not rectangle then
            rectangle = loadComponent('rectangle')
        end
        
        c.resizeRect = { c.size[1] - c.resizeWidth, 0, 
                c.resizeWidth, c.resizeHeight };

        c.component('resizeButton', rectangle { 
            position = c.resizeRect;
            color = { 0.10, 0.10, 0.10, 1.0 };
        });
        
        if not clickable then
            clickable = loadComponent('clickable')
        end

        c.component('resizeClickable', clickable {
            position = c.resizeRect;
            cursor = { 
                x = 8, 
                y = 26, 
                width = 16, 
                height = 16, 
                shape = loadImage("clickable.png")
            }
        });
    end
    finishComponentsCreation()

    if get(tbl.command) then
        -- register panel popup command
        local command = createCommand(get(tbl.command), get(tbl.description))

        -- show or hide panel on command received
        function commandHandler(phase)
            if 0 == phase then
                set(c.visible, not toboolean(get(c.visible)))
                if toboolean(get(c.visible)) then
                    movePanelToTop(c)
                end
            end
            return 0
        end


        -- register created commandhandler
        registerCommandHandler(command, 0, commandHandler)
    end
    
    if panelsPositions and get(c.savePosition) and ('subpanel' ~= name) then
        local pos = panelsPositions[name]
        if pos then
            set(c.position, pos)
        end
    end

    popup(c)

    return c
end

-- save positions of popup components
function savePopupsPositions()
    local positions = { }
    for _k, c in pairs(popups.components) do
        if get(c.savePosition) and ('subpanel' ~= get(c.name)) then
            positions[get(c.name)] = get(c.position)
        end
    end

    if not #positions then
        return
    end

    local fileName = panelDir .. '/panels.txt'
    local f = io.open(fileName, 'w+')
    if nil ~= f then
        savePositionsToFile(f, positions, 'positions')
        f:close()
    else
        logWarning("Can't open file '" .. fileName .. "' for writing")
    end
end


-- call callback function
function callCallback(name, component)
    local handler = rawget(component, name)
    if handler then
        handler()
    end
    for i = #component.components, 1, -1 do
        callCallback(name, component.components[i])
    end
end

-- call callback for both panel and popups
function callCallbackForAll(name)
    callCallback(name, popups)
    callCallback(name, panel)
end

-- called when avionics about to unload
function doneAvionics()
    callCallbackForAll("onAvionicsDone")
    savePopupsPositions()
end


-- traverse visible focused components and call specified function
function traverseFocused(char, key, func)
    if focusedComponentPath then
        local maxVisible = 0
        for i = 1, #focusedComponentPath, 1 do
            local c = focusedComponentPath[i]
            if toboolean(get(c.visible)) then
                maxVisible = i
            else
                break;
            end
        end
        for i = maxVisible, 1, -1 do
            local c = focusedComponentPath[i]
            local res = c[func](c, char, key)
            if res then
                return true
            end
        end
    end
    return false
end

-- called when button pressed
function onKeyDown(char, key)
    return traverseFocused(char, key, 'onKeyDown')
end

-- called when button released
function onKeyUp(char, key)
    return traverseFocused(char, key, 'onKeyUp')
end


-- load script inside component environment
function include(component, name)
    logInfo("including", name)

    local f, subdir = openFile(name)
    if not f then
        logError("can't include script", name)
    else
        if subdir then
            addSearchPath(subdir)
        end
            
        setfenv(f, component)
        f()

        if subdir then
            popSearchPath()
        end
    end
end


-- load sample from file
-- find file using the same rules as for textures
function loadSample(fileName, createTimer)
	if createTimer == nil then createTimer = 0 end
    for _, v in ipairs(searchImagePath) do
        local f = v .. '/' .. fileName
        if isFileExists(f) then
            return loadSampleFromFile(f, createTimer)
        end
    end

    if not isFileExists(fileName) then
        logErrorStacktrace("Can't find sound", fileName)
        return 0
    end

    local s = loadSampleFromFile(fileName, createTimer)
    if 0 == s then
        logErrorStacktrace("Can't load sound", fileName)
    end
    return s
end

-- load reversed sample
function loadSampleReversed(fileName, createTimer)
	if createTimer == nil then createTimer = 0 end
    for _, v in ipairs(searchImagePath) do
        local f = v .. '/' .. fileName
        if isFileExists(f) then
            return loadSampleInReverse(f, createTimer)
        end
    end

    if not isFileExists(fileName) then
        logErrorStacktrace("Can't find sound", fileName)
        return 0
    end

    local s = loadSampleInReverse(fileName, createTimer)
    if 0 == s then
        logErrorStacktrace("Can't load sound", fileName)
    end
    return s
end


-- play sound inside of cockpit
SOUND_INTERNAL = 1

-- play sound outside of cockpit
SOUND_EXTERNAL = 2

-- play sound both inside and outside
SOUND_EVERYWHERE = 3



-- load object from file
-- find file using the same rules as for textures
function loadObject(fileName)
    for _, v in ipairs(searchImagePath) do
        local f = v .. '/' .. fileName
        if isFileExists(f) then
            return loadObjectFromFile(f)
        end
    end

    if not isFileExists(fileName) then
        logErrorStacktrace("Can't find object", fileName)
        return 0
    end

    local o = loadObjectFromFile(fileName)
    if 0 == o then
        logErrorStacktrace("Can't load object", fileName)
    end
    return o
end

-- called whenever the user's plane is positioned at a new airport
function onAirportLoaded()
    callCallbackForAll("onAirportLoaded")
end

-- called whenever new scenery is loaded
function onSceneryLoaded()
    callCallbackForAll("onSceneryLoaded")
end

-- called whenever the user adjusts the number of X-Plane aircraft models
function onAirplaneCountChanged()
    callCallbackForAll("onAirplaneCountChanged")
end

-- called whenever user plane is crashed. Returns 1 if SASL system is need to be reloaded, 0 otherwise
function onPlaneCrash()
    local planeCrashHandler = rawget(panel, 'onPlaneCrash')
    needReload = 1
    if planeCrashHandler then
        needReload = planeCrashHandler()
    end
    if needReload == 0 then
        for i = #panel.components, 1, -1 do
            callCallback('onPlaneCrash', panel.components[i])
        end
        callCallback('onPlaneCrash', popups)
    end
    return needReload
end

-- merges two tables 
function table.merge(t1, t2) 
	t={}
	for k,v in ipairs(t1) do
	table.insert(t, v)
	end 
	for k,v in ipairs(t2) do
	table.insert(t, v)
	end 
	return t 
end

local function transpose(x)
	local r = {}
	
	for i=1,#x[1] do
		r[i]={}
		for j=1,#x do
			r[i][j] = x[j][i]
		end
	end
	
	return r
end

-- extracts N-dimensinal table into one table
function extractArrayData(arr) 
	if assert(type(arr[1]))~='table' then     
		return arr    
	else
		if assert(type(arr[1][1]))~='table' then
			arr = transpose(arr)
		end
		
		local res={}  
		for i=1, #arr do   
			res = table.merge(res, extractArrayData(arr[i]))      
		end
		return res
	end
end

-- creates new interpolator, returns its handle
function newInterpolator(...)
	local arg={...}
	local input = {}
	local value = {}
	
	if #arg == 1 then --and #arg[1]==2 and #arg[1][1]==#arg[1][2] then
		input = {arg[1][1]}
		value = {arg[1][2]}
		return newCPPInterpolator(input, value)		
	end
	
	local N = #arg-1
	local M = #arg[N+1]
	local matrix = arg[N+1]			
	local size=1
	
	
 
	if N==0 then 
		error('number of input arguments into an interpolator must be greater than zero')
		return
	end
 
 
	for i=1,N do
		input[i] = arg[i]  
		size = size*#arg[i]  
	end
 
	for i=1,M do
		local val = matrix[i]     
		value[i] = extractArrayData(val)  
		if #value[i]~=size then 
			error('size dimensions mismatch')
			return
		end
	end
	
	return newCPPInterpolator(input, value)
end

function deleteInterpolator(handle)
	deleteCPPInterpolator(handle)
end

function interpolate(x, interp, flag)
	if assert(type(x))=='number' then  x={x} end
	res = interpolateCPP(interp, x, flag)
	return #res==1 and res[1] or res
end

function selfInterpolator(...)
	local r = {}
	r.interp = newInterpolator(...)
	local temp = function(x, flag) 
					if not flag then flag = 0 end
					return interpolate(x, r.interp, flag) 
				 end
	r.interpolate = temp
		
	return r
end

-- OpenGL identifiers for blending
BLEND_SOURCE_COLOR = 0x0300
BLEND_ONE_MINUS_SOURCE_COLOR = 0x0301
BLEND_SOURCE_ALPHA = 0x0302
BLEND_ONE_MINUS_SOURCE_ALPHA = 0x0303
BLEND_DESTINATION_ALPHA = 0x0304
BLEND_ONE_MINUS_DESTINATION_ALPHA = 0x0305
BLEND_DESTINATION_COLOR = 0x0306
BLEND_ONE_MINUS_DESTINATION_COLOR = 0x0307
BLEND_SOURCE_ALPHA_SATURATE = 0x0308

BLEND_CONSTANT_COLOR = 0x8001
BLEND_ONE_MINUS_CONSTANT_COLOR = 0x8002
BLEND_CONSTANT_ALPHA = 0x8003
BLEND_ONE_MINUS_CONSTANT_ALPHA = 0x8004

BLEND_EQUATION_MIN = 0x8007
BLEND_EQUATION_MAX = 0x8008
BLEND_EQUATION_SUBTRACT = 0x800A
BLEND_EQUATION_REVERSE_SUBTRACT = 0x800B

-- Default blend equation value		
BLEND_EQUATION_ADD = 0x8006
