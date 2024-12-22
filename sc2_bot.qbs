Project {
    name: "SC2 Zabbulator AI"

    SubProject { // more powerful than 'references:'; can set properties for included project
        filePath: "subprojects/sc2_api/sc2_api.qbs"

        Properties {
            sourceDirectory: "subprojects/sc2_api"
        }
    }

    CppApplication {

        Depends { name: "sc2_api" }

        files: ["src/main.cpp"]
    }

}




