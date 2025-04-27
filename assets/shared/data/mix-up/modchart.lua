local mod = 0
local subMod = 0
local modBeat = 0
local modStep = 0
local started = false
local rot = 0
local rotspd = 1
local circAng = math.rad(180)
local centerY = 270
local cnt = {150, 50, -50, -150} -- approximated spacing
local curSide = 1

function onCreate()
    modInit(0)
end

function modInit(Mod)
    mod = Mod
    subMod = 0
    modBeat = 0
    modStep = 0

    for i = 0, 7 do
        resetNote(i)
    end

    if mod == 0 then
        curSide = 1
    end
end

function resetNote(i)
    -- Reset all note properties
    setPropertyFromGroup('strumLineNotes', i, 'x', defaultStrumX(i))
    setPropertyFromGroup('strumLineNotes', i, 'y', defaultStrumY(i))
    setPropertyFromGroup('strumLineNotes', i, 'angle', 0)
    setPropertyFromGroup('strumLineNotes', i, 'direction', 90)
    setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
end

function defaultStrumX(i)
    -- Default strum X (approximate based on engine layout)
    return 92 + (112 * i)
end

function defaultStrumY(i)
    return downscroll and 570 or 50
end

function onUpdate(elapsed)
    if started then
        if mod == 0 then
            rot = rot + elapsed * 5
            for i = 0, 7 do
                setPropertyFromGroup('strumLineNotes', i, 'y', defaultStrumY(i) + math.cos(rot + i) * 20)
            end
        elseif mod == 3 and subMod < 3 then
            circAng = circAng + elapsed * rotspd
            for i = 0, 7 do
                local off = -((i % 4) - 2) / 2.5
                local len = 300
                local an = circAng + off
                if i < 4 then
                    an = an + math.rad(180)
                end
                setPropertyFromGroup('strumLineNotes', i, 'x', cnt[(i % 4) + 1] + math.cos(an) * 300)
                setPropertyFromGroup('strumLineNotes', i, 'y', centerY + math.sin(an) * 200)
                setPropertyFromGroup('strumLineNotes', i, 'direction', math.deg(an))
            end
        end
    end
end

function onBeatHit()
    if curBeat == 0 then
        started = true
    end

    if not started then return end

    if curBeat == 32 then
        subMod = 1
    elseif curBeat == 64 then
        modInit(1)
    elseif curBeat == 128 then
        modInit(2)
    elseif curBeat == 192 then
        modInit(3)
    elseif curBeat == 256 then
        modInit(4)
    elseif curBeat == 288 then
        mod = -1
        for i = 0, 7 do
            noteTweenX('resetX'..i, i, defaultStrumX(i), 1, 'quadInOut')
            noteTweenY('resetY'..i, i, defaultStrumY(i), 1, 'quadInOut')
        end
    elseif curBeat == 328 then
        modInit(5)
    elseif curBeat == 392 then
        modInit(3)
        subMod = 1
    elseif curBeat == 456 then
        subMod = 2
    elseif curBeat == 464 then
        subMod = 3
    end

    -- Mini animation for mod 0
    if mod == 0 then
        for i = 0, 7 do
            local h = 20
            if curBeat % 2 == 0 then h = -h end
            if i % 2 == 0 then h = -h end
            noteTweenY('bounceY'..i, i, defaultStrumY(i) + h, 0.1, 'quadOut')
            runTimer('returnY'..i, 0.1)
        end
    end

    modBeat = modBeat + 1
end

function onTimerCompleted(tag, loops, loopsLeft)
    if string.sub(tag, 1, 7) == 'returnY' then
        local i = tonumber(string.sub(tag, 8))
        noteTweenY('backY'..i, i, defaultStrumY(i), 0.2, 'quadIn')
    end
end

function onStepHit()
    if not started then return end

    if mod == 0 and subMod == 1 then
        if curStep % 8 == 6 then
            for i = 0, 7 do
                setPropertyFromGroup('strumLineNotes', i, 'angle', getPropertyFromGroup('strumLineNotes', i, 'angle') + (i % 2 == 0 and -30 or 30))
            end
        end
    end
end
