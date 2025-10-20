allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val customBuildDir = layout.buildDirectory.dir("build")
rootProject.layout.buildDirectory.value(customBuildDir)
subprojects {
    val newSubprojectBuildDir: Directory = customBuildDir.dir(project.name)
    layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
