.class public Landroid/graphics/RadialGradient;
.super Landroid/graphics/Shader;
.source "RadialGradient.java"


# static fields
.field private static final TYPE_COLORS_AND_POSITIONS:I = 0x1

.field private static final TYPE_COLOR_CENTER_AND_COLOR_EDGE:I = 0x2


# instance fields
.field private mColor0:I

.field private mColor1:I

.field private mColors:[I

.field private mPositions:[F

.field private mRadius:F

.field private mTileMode:Landroid/graphics/Shader$TileMode;

.field private mType:I

.field private mX:F

.field private mY:F


# direct methods
.method public constructor <init>(FFFIILandroid/graphics/Shader$TileMode;)V
    .locals 7
    .parameter "x"
    .parameter "y"
    .parameter "radius"
    .parameter "color0"
    .parameter "color1"
    .parameter "tile"

    .prologue
    invoke-direct {p0}, Landroid/graphics/Shader;-><init>()V

    const/4 v0, 0x0

    cmpg-float v0, p3, v0

    if-gtz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "radius must be > 0"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Landroid/graphics/RadialGradient;->mType:I

    iput p1, p0, Landroid/graphics/RadialGradient;->mX:F

    iput p2, p0, Landroid/graphics/RadialGradient;->mY:F

    iput p3, p0, Landroid/graphics/RadialGradient;->mRadius:F

    iput p4, p0, Landroid/graphics/RadialGradient;->mColor0:I

    iput p5, p0, Landroid/graphics/RadialGradient;->mColor1:I

    iput-object p6, p0, Landroid/graphics/RadialGradient;->mTileMode:Landroid/graphics/Shader$TileMode;

    iget v5, p6, Landroid/graphics/Shader$TileMode;->nativeInt:I

    move v0, p1

    move v1, p2

    move v2, p3

    move v3, p4

    move v4, p5

    invoke-static/range {v0 .. v5}, Landroid/graphics/RadialGradient;->nativeCreate2(FFFIII)I

    move-result v0

    iput v0, p0, Landroid/graphics/Shader;->native_instance:I

    iget v0, p0, Landroid/graphics/Shader;->native_instance:I

    iget v6, p6, Landroid/graphics/Shader$TileMode;->nativeInt:I

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v6}, Landroid/graphics/RadialGradient;->nativePostCreate2(IFFFIII)I

    move-result v0

    iput v0, p0, Landroid/graphics/Shader;->native_shader:I

    return-void
.end method

.method public constructor <init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V
    .locals 7
    .parameter "x"
    .parameter "y"
    .parameter "radius"
    .parameter "colors"
    .parameter "positions"
    .parameter "tile"

    .prologue
    invoke-direct {p0}, Landroid/graphics/Shader;-><init>()V

    const/4 v0, 0x0

    cmpg-float v0, p3, v0

    if-gtz v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "radius must be > 0"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    array-length v0, p4

    const/4 v1, 0x2

    if-ge v0, v1, :cond_1

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "needs >= 2 number of colors"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    if-eqz p5, :cond_2

    array-length v0, p4

    array-length v1, p5

    if-eq v0, v1, :cond_2

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "color and position arrays must be of equal length"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    const/4 v0, 0x1

    iput v0, p0, Landroid/graphics/RadialGradient;->mType:I

    iput p1, p0, Landroid/graphics/RadialGradient;->mX:F

    iput p2, p0, Landroid/graphics/RadialGradient;->mY:F

    iput p3, p0, Landroid/graphics/RadialGradient;->mRadius:F

    iput-object p4, p0, Landroid/graphics/RadialGradient;->mColors:[I

    iput-object p5, p0, Landroid/graphics/RadialGradient;->mPositions:[F

    iput-object p6, p0, Landroid/graphics/RadialGradient;->mTileMode:Landroid/graphics/Shader$TileMode;

    iget v5, p6, Landroid/graphics/Shader$TileMode;->nativeInt:I

    move v0, p1

    move v1, p2

    move v2, p3

    move-object v3, p4

    move-object v4, p5

    invoke-static/range {v0 .. v5}, Landroid/graphics/RadialGradient;->nativeCreate1(FFF[I[FI)I

    move-result v0

    iput v0, p0, Landroid/graphics/Shader;->native_instance:I

    iget v0, p0, Landroid/graphics/Shader;->native_instance:I

    iget v6, p6, Landroid/graphics/Shader$TileMode;->nativeInt:I

    move v1, p1

    move v2, p2

    move v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-static/range {v0 .. v6}, Landroid/graphics/RadialGradient;->nativePostCreate1(IFFF[I[FI)I

    move-result v0

    iput v0, p0, Landroid/graphics/Shader;->native_shader:I

    return-void
.end method

.method private static native nativeCreate1(FFF[I[FI)I
.end method

.method private static native nativeCreate2(FFFIII)I
.end method

.method private static native nativePostCreate1(IFFF[I[FI)I
.end method

.method private static native nativePostCreate2(IFFFIII)I
.end method


# virtual methods
.method protected copy()Landroid/graphics/Shader;
    .locals 7

    .prologue
    iget v1, p0, Landroid/graphics/RadialGradient;->mType:I

    packed-switch v1, :pswitch_data_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "RadialGradient should be created with either colors and positions or center color and edge color"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :pswitch_0
    new-instance v0, Landroid/graphics/RadialGradient;

    iget v1, p0, Landroid/graphics/RadialGradient;->mX:F

    iget v2, p0, Landroid/graphics/RadialGradient;->mY:F

    iget v3, p0, Landroid/graphics/RadialGradient;->mRadius:F

    iget-object v4, p0, Landroid/graphics/RadialGradient;->mColors:[I

    invoke-virtual {v4}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, [I

    iget-object v5, p0, Landroid/graphics/RadialGradient;->mPositions:[F

    if-eqz v5, :cond_0

    iget-object v5, p0, Landroid/graphics/RadialGradient;->mPositions:[F

    invoke-virtual {v5}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [F

    :goto_0
    iget-object v6, p0, Landroid/graphics/RadialGradient;->mTileMode:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v6}, Landroid/graphics/RadialGradient;-><init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V

    .local v0, copy:Landroid/graphics/RadialGradient;
    :goto_1
    invoke-virtual {p0, v0}, Landroid/graphics/Shader;->copyLocalMatrix(Landroid/graphics/Shader;)V

    return-object v0

    .end local v0           #copy:Landroid/graphics/RadialGradient;
    :cond_0
    const/4 v5, 0x0

    goto :goto_0

    :pswitch_1
    new-instance v0, Landroid/graphics/RadialGradient;

    iget v1, p0, Landroid/graphics/RadialGradient;->mX:F

    iget v2, p0, Landroid/graphics/RadialGradient;->mY:F

    iget v3, p0, Landroid/graphics/RadialGradient;->mRadius:F

    iget v4, p0, Landroid/graphics/RadialGradient;->mColor0:I

    iget v5, p0, Landroid/graphics/RadialGradient;->mColor1:I

    iget-object v6, p0, Landroid/graphics/RadialGradient;->mTileMode:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v6}, Landroid/graphics/RadialGradient;-><init>(FFFIILandroid/graphics/Shader$TileMode;)V

    .restart local v0       #copy:Landroid/graphics/RadialGradient;
    goto :goto_1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
