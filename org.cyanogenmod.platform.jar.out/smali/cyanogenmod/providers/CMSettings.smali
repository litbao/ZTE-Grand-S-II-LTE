.class public final Lcyanogenmod/providers/CMSettings;
.super Ljava/lang/Object;
.source "CMSettings.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcyanogenmod/providers/CMSettings$Global;,
        Lcyanogenmod/providers/CMSettings$Secure;,
        Lcyanogenmod/providers/CMSettings$System;,
        Lcyanogenmod/providers/CMSettings$NameValueCache;,
        Lcyanogenmod/providers/CMSettings$CMSettingNotFoundException;
    }
.end annotation


# static fields
.field public static final AUTHORITY:Ljava/lang/String; = "cmsettings"

.field private static final LOCAL_LOGV:Z = false

.field private static final TAG:Ljava/lang/String; = "CMSettings"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 777
    return-void
.end method
