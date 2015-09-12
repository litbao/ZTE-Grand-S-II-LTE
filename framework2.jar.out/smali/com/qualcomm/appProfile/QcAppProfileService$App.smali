.class Lcom/qualcomm/appProfile/QcAppProfileService$App;
.super Ljava/lang/Object;
.source "QcAppProfileService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/qualcomm/appProfile/QcAppProfileService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "App"
.end annotation


# instance fields
.field public final cpuBias:I

.field public final packageName:Ljava/lang/String;

.field public final powerMode:I

.field public final tskinValue:I


# direct methods
.method constructor <init>(Ljava/lang/String;III)V
    .locals 0
    .parameter "_packageName"
    .parameter "_cpuBias"
    .parameter "_powerMode"
    .parameter "_tskinValue"

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/qualcomm/appProfile/QcAppProfileService$App;->packageName:Ljava/lang/String;

    iput p2, p0, Lcom/qualcomm/appProfile/QcAppProfileService$App;->cpuBias:I

    iput p3, p0, Lcom/qualcomm/appProfile/QcAppProfileService$App;->powerMode:I

    iput p4, p0, Lcom/qualcomm/appProfile/QcAppProfileService$App;->tskinValue:I

    return-void
.end method
