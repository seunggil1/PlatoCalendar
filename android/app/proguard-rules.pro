# com.google.errorprone.annotations.*
-keep class com.google.errorprone.annotations.CanIgnoreReturnValue
-keep class com.google.errorprone.annotations.CheckReturnValue
-keep class com.google.errorprone.annotations.Immutable
-keep class com.google.errorprone.annotations.RestrictedApi

# javax.annotation.*
-keep class javax.annotation.Nullable
-keep class javax.annotation.concurrent.GuardedBy

# 혹은 경고만 무시하고 싶다면(필요에 따라)
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**