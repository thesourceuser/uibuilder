local module = {
    instance=game:GetService("Players").LocalPlayer.PlayerGui, 
    attributes={},
    children={},
    listeners={},
 
    toall={},
 
    settoall=function(self, class, attributes)
        self.toall[class] = table.clone(attributes)
    end
}
 
local meta = {}
meta.__index = meta
 
function meta:newchild(instance, attributes)
    local class = {}
    class.instance = Instance.new(instance)
    class.attributes = {}
    class.listeners = {}
    class.children = {}
 
    for c, attrs in pairs(module.toall) do
        if class.instance:IsA(c) then
            for i, v in pairs(attrs) do
                class.attributes[i] = v
            end
        end
    end
 
    for i, v in pairs(attributes) do
        class.attributes[i] = v
    end
 
    local new = setmetatable(class, meta)
    table.insert(self.children, new)
 
    return new
end
 
function meta:create(instance, attributes)
    local me = self:newchild(instance, attributes)
 
    -- build me
    me:build()
    me.instance.Parent = self.instance
 
    return self
end
 
function meta:newlistener(index, func)
 
end
 
function meta:build()
    if self.built == true then return end
    self.built = true
 
    for i, v in pairs(self.attributes) do
        self.instance[i] = v
    end
 
    for i, v in ipairs(self.children) do
        v:build()
        v.instance.Parent = self.instance
    end
end
 
return setmetatable(module, meta)
