import qbs.Process

Project {
    name: "SC2 API subproject"

    StaticLibrary {
        name: "sc2_api"
        Depends { name: "cpp" }

        property string libDir: sourceDirectory + "/cpp-sc2"
        property string buildDir: libDir + "/build"

        Rule {
            id: build
            alwaysRun: true // let CMake handle the update deltas
            multiplex: true // needs to be set to allow empty input list

            Artifact {
                filePath: product.buildDir + "/bin/libsc2api.a"
                fileTags: ["staticlibrary"]
            }

            prepare: {
                var cmd = new Process()
                cmd.exec("nproc", [])
                var cpuCount = cmd.readStdOut()
                var verbosity = "1"

                //cmd.environment = { "VERBOSE": verbosity };
                cmd.setWorkingDirectory(product.libDir)
                cmd.exec("cmake", ["-B", product.buildDir])
                cmd.exec("cmake", ["--build", product.buildDir, "-j", cpuCount])
                //var output = cmd.readStdOut()
                //var error = cmd.readStdErr()

                var commands = [
                    new Command("pwd", []),
                    //new Command("cmake", ["-S", product.libDir, "-B", product.buildDir]),
                    //new Command("cmake", ["--build", product.buildDir, "-j", cpuCount]),
                ];
                commands[0].workingDirectory = product.libDir
                commands[0].description = "Execution of a maybe useful pwd"
                // commands[0].description = "Generating CMake build directory " + product.buildDir + " in " + product.libDir + " " + output + error
                // commands[0].workingDirectory = product.libDir
                // commands[1].description = "Calling CMake to build SC2 API"
                // commands[1].workingDirectory = product.libDir
                // commands[1].environment = { "VERBOSE": verbosity };

                return commands;
            }
        }

        Export { // make these available to any products that depend on this one
            Depends { name: "cpp" }
            cpp.includePaths: [exportingProduct.libDir]
        }
    }
}
