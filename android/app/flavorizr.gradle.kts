import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "org.nics.ebitcoinics.dev"
            resValue(type = "string", name = "app_name", value = "eBitcoinics - Dev")
        }
        create("qa") {
            dimension = "flavor-type"
            applicationId = "org.nics.ebitcoinics"
            resValue(type = "string", name = "app_name", value = "eBitcoinics - QA")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "org.nics.ebitcoinics"
            resValue(type = "string", name = "app_name", value = "eBitcoinics")
        }
    }
}