.class public final Landroid/util/Config;
.super Ljava/lang/Object;
.source "Config.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final DEBUG:Z = false
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final FORCE_DISABLE_THEME_ZTE:Z = false

.field public static final LOGD:Z = true
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final LOGV:Z = false
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final PROFILE:Z = false
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final RELEASE:Z = true
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field public static final THEME_DARK:I = 0x103006b

.field public static final ZTE_FEATURE_AUDIENCE_WAKEUP:Z = true

.field public static final ZTE_FEATURE_DISK_CLEANUP:Z = true

.field public static ZTE_FEATURE_PPPOE_SWITCH:Z = false

.field public static final ZTE_FEATURE_SECURITY_EXTENSION:Z = false

.field public static final ZTE_FEATURE_USAGE_STATS:Z = true

.field public static final ZTE_TELECOM:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 80
    const/4 v0, 0x0

    sput-boolean v0, Landroid/util/Config;->ZTE_FEATURE_PPPOE_SWITCH:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
