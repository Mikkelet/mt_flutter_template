import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("develop") {
            dimension = "flavor-type"
            applicationId = "com.example.app.dev"
            resValue(type = "string", name = "app_name", value = "My Example app")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.example.app"
            resValue(type = "string", name = "app_name", value = "My Example app")
        }
    }
}