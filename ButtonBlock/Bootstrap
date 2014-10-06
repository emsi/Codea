-- Bootsrtaping project

baseUrl="https://raw.githubusercontent.com/emsi/Codea/master/ButtonBlock/"
codeTabs={"RectButton","RectBlock","TriangleButton","TriangleBlock","Main"}
index=0

function bootstrap(code)
    local tab=codeTabs[index]
    if code then
        saveProjectTab(tab, code)
        print("Loaded "..tab)
    end
    if index>=#codeTabs then
        print ("Loading completed")
        sound("Game Sounds One:Bell 2")
        return
    end
    index = index + 1
    http.request(baseUrl..codeTabs[index]..".lua", bootstrap,
    function()
        primt("ERROR: "..tab.. " failed!")
        sound("Game Sounds One:Crowd Boo")
        close()
    end)
end
