.class public Lcom/android/internal/app/RingtonePickerActivity;
.super Landroid/app/Activity;
.source "RingtonePickerActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/TabHost$TabContentFactory;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;
    }
.end annotation


# static fields
.field private static final ALARM_TYPE:I = 0x4

.field private static final DEFAULT_ID:J = 0x153158eL

.field private static final ID_COLUMN_INDEX:I = 0x0

.field private static final MUSIC_TONE:I = 0x6f

.field static final MY_QUERY_TOKEN:I = 0x2a

.field private static final NOTIFICATION_TYPE:I = 0x2

.field private static final RECORD_TONE:I = 0x70

.field private static final RINGTONE_TYPE:I = 0x1

.field private static final SAVE_CLICKED_POS:Ljava/lang/String; = "clicked_pos"

.field private static final SILENT_ID:J = 0xa98ac7L

.field static final SYSTEM_TONE:I = 0x64

.field private static final TAB_MUSIC:Ljava/lang/String; = "tab_music"

.field private static final TAB_RECORD:Ljava/lang/String; = "tab_record"

.field private static final TAB_SYSTEM:Ljava/lang/String; = "tab_system"

.field private static final TITLE_COLUMN_INDEX:I = 0x1

.field private static final URI_COLUMN_INDEX:I = 0x2


# instance fields
.field private BaseUri:Landroid/net/Uri;

.field private adapter:Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;

.field private audioManager:Landroid/media/AudioManager;

.field private cancelBtn:Landroid/widget/Button;

.field private defaultItemChecked:Z

.field private defaultView:Landroid/view/View;

.field private listView:Landroid/widget/ListView;

.field private mAudioFocusListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

.field private mCurTab:Ljava/lang/String;

.field private mExistingUri:Landroid/net/Uri;

.field private mHasDefaultItem:Z

.field private mHasSilentItem:Z

.field private mIsDrmValid:Z

.field mListShown:Z

.field private mMediaPlayer:Landroid/media/MediaPlayer;

.field private mRingtoneManager:Landroid/media/RingtoneManager;

.field private mSelectedId:J

.field private mSelectedUri:Landroid/net/Uri;

.field private mStaticItemCount:I

.field private mUriForDefaultItem:Landroid/net/Uri;

.field private okBtn:Landroid/widget/Button;

.field private silentItemChecked:Z

.field private silentView:Landroid/view/View;

.field private tabName:I

.field private toneActivityType:I

.field private toneCur:Landroid/database/Cursor;

.field private toneType:I

.field private where:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 42
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 56
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 76
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    .line 90
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mIsDrmValid:Z

    .line 696
    return-void
.end method

.method static synthetic access$002(Lcom/android/internal/app/RingtonePickerActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 42
    iput-object p1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mCurTab:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$100(Lcom/android/internal/app/RingtonePickerActivity;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    return v0
.end method

.method static synthetic access$200(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$300(Lcom/android/internal/app/RingtonePickerActivity;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    return v0
.end method

.method static synthetic access$400(Lcom/android/internal/app/RingtonePickerActivity;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    return v0
.end method

.method static synthetic access$500(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$600(Lcom/android/internal/app/RingtonePickerActivity;)Z
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    return v0
.end method

.method static synthetic access$700(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/net/Uri;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    return-object v0
.end method

.method static synthetic access$800(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/net/Uri;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;

    return-object v0
.end method

.method static synthetic access$900(Lcom/android/internal/app/RingtonePickerActivity;)J
    .locals 2
    .param p0, "x0"    # Lcom/android/internal/app/RingtonePickerActivity;

    .prologue
    .line 42
    iget-wide v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    return-wide v0
.end method

.method private addDefaultStaticItem(Landroid/widget/ListView;I)I
    .locals 4
    .param p1, "listView"    # Landroid/widget/ListView;
    .param p2, "textResId"    # I

    .prologue
    .line 309
    invoke-virtual {p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x1090019

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultView:Landroid/view/View;

    .line 311
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultView:Landroid/view/View;

    const v2, 0x1020016

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 312
    .local v0, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(I)V

    .line 313
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultView:Landroid/view/View;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-virtual {p1, v1, v2, v3}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    .line 314
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mStaticItemCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mStaticItemCount:I

    .line 315
    invoke-virtual {p1}, Landroid/widget/ListView;->getHeaderViewsCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    return v1
.end method

.method private addSilendStaticItem(Landroid/widget/ListView;I)I
    .locals 4
    .param p1, "listView"    # Landroid/widget/ListView;
    .param p2, "textResId"    # I

    .prologue
    .line 298
    invoke-virtual {p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x1090019

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentView:Landroid/view/View;

    .line 300
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentView:Landroid/view/View;

    const v2, 0x1020016

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 301
    .local v0, "textView":Landroid/widget/TextView;
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(I)V

    .line 302
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentView:Landroid/view/View;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-virtual {p1, v1, v2, v3}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    .line 303
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mStaticItemCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mStaticItemCount:I

    .line 304
    invoke-virtual {p1}, Landroid/widget/ListView;->getHeaderViewsCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    return v1
.end method

.method private getCursor(ILjava/lang/String;)Landroid/database/Cursor;
    .locals 8
    .param p1, "tabName"    # I
    .param p2, "were"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    .line 223
    const-string v0, "zxw"

    const-string v1, "getCursor"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 224
    const-string v0, "zxw"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getCursortabName"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 225
    sparse-switch p1, :sswitch_data_0

    .line 257
    :goto_0
    return-object v2

    .line 229
    :sswitch_0
    const/4 v0, 0x2

    new-array v6, v0, [Landroid/database/Cursor;

    .line 230
    .local v6, "ringtonesCursors":[Landroid/database/Cursor;
    const/4 v7, 0x0

    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->INTERNAL_CONTENT_URI:Landroid/net/Uri;

    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    const-string v5, "title COLLATE LOCALIZED ASC"

    move-object v4, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    aput-object v0, v6, v7

    .line 236
    new-instance v2, Landroid/database/MergeCursor;

    invoke-direct {v2, v6}, Landroid/database/MergeCursor;-><init>([Landroid/database/Cursor;)V

    goto :goto_0

    .line 246
    .end local v6    # "ringtonesCursors":[Landroid/database/Cursor;
    :sswitch_1
    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    const-string v5, "title COLLATE LOCALIZED ASC"

    move-object v4, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v2

    goto :goto_0

    .line 225
    nop

    :sswitch_data_0
    .sparse-switch
        0x64 -> :sswitch_0
        0x6f -> :sswitch_1
        0x70 -> :sswitch_1
    .end sparse-switch
.end method

.method private getMusicCursor()Landroid/database/Cursor;
    .locals 7

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x2

    const/4 v4, 0x1

    .line 359
    new-array v2, v6, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v1, "_id"

    aput-object v1, v2, v0

    const-string v0, "title"

    aput-object v0, v2, v4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v5

    const/4 v0, 0x3

    const-string v1, "title_key"

    aput-object v1, v2, v0

    .line 363
    .local v2, "mediaColumns":[Ljava/lang/String;
    const-string v3, "_data NOT LIKE \'%/Records/%\' AND (is_music=1 OR "

    .line 365
    .local v3, "queryFilter":Ljava/lang/String;
    iget v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    if-ne v0, v4, :cond_0

    .line 366
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "is_ringtone=1)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 379
    :goto_0
    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const/4 v4, 0x0

    const-string v5, "title_key"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    return-object v0

    .line 368
    :cond_0
    iget v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    if-ne v0, v5, :cond_1

    .line 369
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "is_notification=1)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 371
    :cond_1
    iget v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    if-ne v0, v6, :cond_2

    .line 372
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "is_alarm=1)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 375
    :cond_2
    const-string v3, "is_music=1 AND _data NOT LIKE \'%/Records/%\'"

    goto :goto_0
.end method

.method private getRecorderCursor()Landroid/database/Cursor;
    .locals 6

    .prologue
    .line 386
    const/4 v0, 0x4

    new-array v2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v1, "_id"

    aput-object v1, v2, v0

    const/4 v0, 0x1

    const-string v1, "title"

    aput-object v1, v2, v0

    const/4 v0, 0x2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v4, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "\""

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v0

    const/4 v0, 0x3

    const-string v1, "title_key"

    aput-object v1, v2, v0

    .line 390
    .local v2, "mediaColumns":[Ljava/lang/String;
    const-string v3, "(_data LIKE \'%/Records/%.m4a\')"

    .line 391
    .local v3, "queryFilter":Ljava/lang/String;
    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    const/4 v4, 0x0

    const-string v5, "title_key"

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    return-object v0
.end method

.method private getRingtonePosition(Landroid/net/Uri;ILjava/lang/String;)I
    .locals 9
    .param p1, "ringtoneUri"    # Landroid/net/Uri;
    .param p2, "tabName"    # I
    .param p3, "were"    # Ljava/lang/String;

    .prologue
    const/4 v6, -0x1

    .line 263
    if-nez p1, :cond_0

    move v3, v6

    .line 293
    :goto_0
    return v3

    .line 265
    :cond_0
    invoke-direct {p0, p2, p3}, Lcom/android/internal/app/RingtonePickerActivity;->getCursor(ILjava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 266
    .local v1, "cursor":Landroid/database/Cursor;
    invoke-interface {v1}, Landroid/database/Cursor;->getCount()I

    move-result v2

    .line 268
    .local v2, "cursorCount":I
    invoke-interface {v1}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v7

    if-nez v7, :cond_1

    .line 269
    const-string v7, "zxw"

    const-string v8, "getRingtonePosition 1"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v6

    .line 270
    goto :goto_0

    .line 274
    :cond_1
    const/4 v0, 0x0

    .line 275
    .local v0, "currentUri":Landroid/net/Uri;
    const/4 v4, 0x0

    .line 276
    .local v4, "previousUriString":Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    if-ge v3, v2, :cond_5

    .line 277
    const/4 v7, 0x2

    invoke-interface {v1, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    .line 278
    .local v5, "uriString":Ljava/lang/String;
    if-eqz v0, :cond_2

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 279
    :cond_2
    invoke-static {v5}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    .line 282
    :cond_3
    const/4 v7, 0x0

    invoke-interface {v1, v7}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v7

    invoke-static {v0, v7, v8}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v7

    invoke-virtual {p1, v7}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 284
    const-string v6, "zxw"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "getRingtonePosition i"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 288
    :cond_4
    const/4 v7, 0x1

    invoke-interface {v1, v7}, Landroid/database/Cursor;->move(I)Z

    .line 290
    move-object v4, v5

    .line 276
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 292
    .end local v5    # "uriString":Ljava/lang/String;
    :cond_5
    const-string v7, "zxw"

    const-string v8, "getRingtonePosition 2"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move v3, v6

    .line 293
    goto :goto_0
.end method


# virtual methods
.method public createTabContent(Ljava/lang/String;)Landroid/view/View;
    .locals 11
    .param p1, "tag"    # Ljava/lang/String;

    .prologue
    const-wide/32 v9, 0x153158e

    const-wide/32 v7, 0xa98ac7

    const/4 v0, 0x0

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 399
    const-string v1, "lys"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "createTabContent tag == "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 400
    const-string v1, "tab_system"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 402
    const/16 v1, 0x64

    iput v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->tabName:I

    .line 403
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    const/4 v2, 0x4

    if-ne v1, v2, :cond_1

    .line 405
    const-string v1, "is_alarm"

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    .line 425
    :cond_0
    :goto_0
    const-string v1, "lys"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "tabContent where == "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 429
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->tabName:I

    sparse-switch v1, :sswitch_data_0

    .line 530
    :goto_1
    return-object v0

    .line 407
    :cond_1
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    if-ne v1, v4, :cond_2

    .line 409
    const-string v1, "is_ringtone"

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    goto :goto_0

    .line 411
    :cond_2
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 413
    const-string v1, "is_notification"

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    goto :goto_0

    .line 416
    :cond_3
    const-string v1, "tab_music"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 418
    const/16 v1, 0x6f

    iput v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->tabName:I

    goto :goto_0

    .line 422
    :cond_4
    const/16 v1, 0x70

    iput v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->tabName:I

    goto :goto_0

    .line 432
    :sswitch_0
    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->tabName:I

    iget-object v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    invoke-direct {p0, v1, v2}, Lcom/android/internal/app/RingtonePickerActivity;->getCursor(ILjava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    .line 437
    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->INTERNAL_CONTENT_URI:Landroid/net/Uri;

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;

    .line 488
    :goto_2
    const-string v1, "lys"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "toneCur == "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 489
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    if-nez v1, :cond_5

    .line 491
    const-string v1, "lys"

    const-string v2, "createTabContent toneCur== null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 493
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 494
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    .line 495
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    goto :goto_1

    .line 441
    :sswitch_1
    const-string v1, "mime_type != \'audio/amr\' and is_drm == 0  AND title != \'hangout_ringtone\' AND title != \'Join Hangout\' AND title != \'hangout_dingtone\' "

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    .line 443
    invoke-direct {p0}, Lcom/android/internal/app/RingtonePickerActivity;->getMusicCursor()Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    .line 459
    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;

    goto :goto_2

    .line 466
    :sswitch_2
    const-string v1, "mime_type = \'audio/amr\'"

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->where:Ljava/lang/String;

    .line 467
    invoke-direct {p0}, Lcom/android/internal/app/RingtonePickerActivity;->getRecorderCursor()Landroid/database/Cursor;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    .line 482
    sget-object v1, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    iput-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;

    goto :goto_2

    .line 498
    :cond_5
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v0, :cond_6

    .line 500
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mExistingUri:Landroid/net/Uri;

    invoke-static {v0}, Landroid/media/RingtoneManager;->isDefault(Landroid/net/Uri;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 502
    iput-boolean v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 503
    iput-wide v9, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 507
    :cond_6
    iget-boolean v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    if-eqz v0, :cond_7

    .line 509
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mExistingUri:Landroid/net/Uri;

    if-nez v0, :cond_7

    .line 511
    iput-boolean v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    .line 512
    iput-wide v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 517
    :cond_7
    iget-wide v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    cmp-long v0, v0, v9

    if-eqz v0, :cond_8

    iget-wide v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    cmp-long v0, v0, v7

    if-eqz v0, :cond_8

    .line 519
    iput-boolean v6, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    .line 520
    iput-boolean v6, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 524
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    if-eqz v0, :cond_8

    .line 525
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    invoke-static {v0}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 527
    :cond_8
    new-instance v0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;

    const v3, 0x1090019

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    new-array v5, v6, [Ljava/lang/String;

    new-array v6, v6, [I

    move-object v1, p0

    move-object v2, p0

    invoke-direct/range {v0 .. v6}, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;-><init>(Lcom/android/internal/app/RingtonePickerActivity;Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V

    iput-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->adapter:Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;

    .line 528
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->adapter:Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    .line 529
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    .line 530
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    goto/16 :goto_1

    .line 429
    nop

    :sswitch_data_0
    .sparse-switch
        0x64 -> :sswitch_0
        0x6f -> :sswitch_1
        0x70 -> :sswitch_2
    .end sparse-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v6, -0x1

    .line 543
    const-string v2, "lys"

    const-string v3, "onClick called"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    iget v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    if-ne v2, v6, :cond_0

    .line 545
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    .line 547
    :cond_0
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .line 548
    .local v1, "resultIntent":Landroid/content/Intent;
    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 549
    .local v0, "resolver":Landroid/content/ContentResolver;
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v2

    sparse-switch v2, :sswitch_data_0

    .line 607
    :goto_0
    return-void

    .line 569
    :sswitch_0
    const-string v2, "lys"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onClick values == "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 585
    iget-wide v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    const-wide/32 v4, 0xa98ac7

    cmp-long v2, v2, v4

    if-nez v2, :cond_2

    .line 587
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 594
    :cond_1
    :goto_1
    const-string v2, "android.intent.extra.ringtone.PICKED_URI"

    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 595
    invoke-virtual {p0, v6, v1}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    .line 598
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    goto :goto_0

    .line 588
    :cond_2
    iget-wide v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    const-wide/32 v4, 0x153158e

    cmp-long v2, v2, v4

    if-nez v2, :cond_1

    .line 590
    iget-object v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    iput-object v2, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    goto :goto_1

    .line 602
    :sswitch_1
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Landroid/app/Activity;->setResult(I)V

    .line 603
    invoke-virtual {p0}, Lcom/android/internal/app/RingtonePickerActivity;->stopMediaPlayer()V

    .line 604
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    goto :goto_0

    .line 549
    nop

    :sswitch_data_0
    .sparse-switch
        0x1020291 -> :sswitch_1
        0x10202b4 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 13
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v12, -0x1

    const/4 v11, 0x0

    const/4 v10, 0x1

    .line 109
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 111
    invoke-virtual {p0, v10}, Landroid/app/Activity;->requestWindowFeature(I)Z

    .line 112
    const v7, 0x1090018

    invoke-virtual {p0, v7}, Landroid/app/Activity;->setContentView(I)V

    .line 113
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x104001f

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v6

    .line 114
    .local v6, "sysTitle":Ljava/lang/CharSequence;
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x1040022

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    .line 115
    .local v0, "MusicTitle":Ljava/lang/CharSequence;
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x1040023

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 116
    .local v1, "RecordTitle":Ljava/lang/CharSequence;
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v4

    .line 117
    .local v4, "intent":Landroid/content/Intent;
    const-string v7, "android.intent.extra.ringtone.TYPE"

    invoke-virtual {v4, v7, v12}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v7

    iput v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    .line 118
    const-string v7, "duwenhua"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "ringPick get toneType:"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v9, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 124
    const-string v7, "android.intent.extra.ringtone.SHOW_DEFAULT"

    invoke-virtual {v4, v7, v10}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v7

    iput-boolean v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    .line 125
    const-string v7, "android.intent.extra.ringtone.DEFAULT_URI"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v7

    check-cast v7, Landroid/net/Uri;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    .line 126
    const-string v7, "lys"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "mUriForDefaultItem == "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    if-nez v7, :cond_0

    .line 128
    sget-object v7, Landroid/provider/Settings$System;->DEFAULT_RINGTONE_URI:Landroid/net/Uri;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    .line 130
    :cond_0
    if-eqz p1, :cond_1

    .line 131
    const-string v7, "clicked_pos"

    const-wide/16 v8, -0x1

    invoke-virtual {p1, v7, v8, v9}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v7

    iput-wide v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 133
    :cond_1
    const-string v7, "android.intent.extra.ringtone.SHOW_SILENT"

    invoke-virtual {v4, v7, v10}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v7

    iput-boolean v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    .line 134
    const-string v7, "android.intent.extra.ringtone.EXISTING_URI"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v7

    check-cast v7, Landroid/net/Uri;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mExistingUri:Landroid/net/Uri;

    .line 135
    const-string v7, "lys"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "mExistingUri == "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/android/internal/app/RingtonePickerActivity;->mExistingUri:Landroid/net/Uri;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 136
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mExistingUri:Landroid/net/Uri;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 143
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    .line 144
    .local v2, "action":Ljava/lang/String;
    const-string v7, "lys"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "PT Intent action == "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 145
    new-instance v7, Landroid/media/RingtoneManager;

    invoke-direct {v7, p0}, Landroid/media/RingtoneManager;-><init>(Landroid/app/Activity;)V

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    .line 146
    const-string v7, "android.intent.extra.ringtone.INCLUDE_DRM"

    const/4 v8, 0x0

    invoke-virtual {v4, v7, v8}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v3

    .line 147
    .local v3, "includeDrm":Z
    const-string v7, "lys"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "includeDrm =="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 148
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    invoke-virtual {v7, v3}, Landroid/media/RingtoneManager;->setIncludeDrm(Z)V

    .line 149
    iget v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    if-eq v7, v12, :cond_2

    .line 150
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    iget v8, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneType:I

    invoke-virtual {v7, v8}, Landroid/media/RingtoneManager;->setType(I)V

    .line 156
    :cond_2
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    invoke-virtual {v7}, Landroid/media/RingtoneManager;->inferStreamType()I

    move-result v7

    invoke-virtual {p0, v7}, Landroid/app/Activity;->setVolumeControlStream(I)V

    .line 157
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    invoke-virtual {v7}, Landroid/media/RingtoneManager;->getActivityType()I

    move-result v7

    iput v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    .line 158
    iget v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    const/4 v8, 0x4

    if-ne v7, v8, :cond_6

    .line 159
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x1040020

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v6

    .line 166
    :cond_3
    :goto_0
    new-instance v7, Landroid/widget/ListView;

    invoke-direct {v7, p0}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    .line 167
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v7, p0}, Landroid/widget/AdapterView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    .line 169
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v7, v10}, Landroid/widget/AbsListView;->setFastScrollEnabled(Z)V

    .line 171
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    const v8, 0x1020004

    invoke-virtual {p0, v8}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/widget/AdapterView;->setEmptyView(Landroid/view/View;)V

    .line 175
    iget-boolean v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v7, :cond_4

    .line 177
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    const v8, 0x1040468

    invoke-direct {p0, v7, v8}, Lcom/android/internal/app/RingtonePickerActivity;->addDefaultStaticItem(Landroid/widget/ListView;I)I

    .line 180
    :cond_4
    iget-boolean v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    if-eqz v7, :cond_5

    .line 181
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    const v8, 0x104046a

    invoke-direct {p0, v7, v8}, Lcom/android/internal/app/RingtonePickerActivity;->addSilendStaticItem(Landroid/widget/ListView;I)I

    .line 183
    :cond_5
    const-string v7, "audio"

    invoke-virtual {p0, v7}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/media/AudioManager;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->audioManager:Landroid/media/AudioManager;

    .line 184
    new-instance v7, Lcom/android/internal/app/RingtonePickerActivity$1;

    invoke-direct {v7, p0}, Lcom/android/internal/app/RingtonePickerActivity$1;-><init>(Lcom/android/internal/app/RingtonePickerActivity;)V

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mAudioFocusListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    .line 190
    const v7, 0x10202b4

    invoke-virtual {p0, v7}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/Button;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->okBtn:Landroid/widget/Button;

    .line 191
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->okBtn:Landroid/widget/Button;

    invoke-virtual {v7, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 192
    const v7, 0x1020291

    invoke-virtual {p0, v7}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/Button;

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->cancelBtn:Landroid/widget/Button;

    .line 193
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->cancelBtn:Landroid/widget/Button;

    invoke-virtual {v7, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 195
    const v7, 0x1020012

    invoke-virtual {p0, v7}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/TabHost;

    .line 196
    .local v5, "mTabHost":Landroid/widget/TabHost;
    invoke-virtual {v5}, Landroid/widget/TabHost;->setup()V

    .line 197
    const-string v7, "tab_system"

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->newTabSpec(Ljava/lang/String;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, v6, v11}, Landroid/widget/TabHost$TabSpec;->setIndicator(Ljava/lang/CharSequence;Landroid/graphics/drawable/Drawable;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, p0}, Landroid/widget/TabHost$TabSpec;->setContent(Landroid/widget/TabHost$TabContentFactory;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->addTab(Landroid/widget/TabHost$TabSpec;)V

    .line 199
    const-string v7, "tab_music"

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->newTabSpec(Ljava/lang/String;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, v0, v11}, Landroid/widget/TabHost$TabSpec;->setIndicator(Ljava/lang/CharSequence;Landroid/graphics/drawable/Drawable;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, p0}, Landroid/widget/TabHost$TabSpec;->setContent(Landroid/widget/TabHost$TabContentFactory;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->addTab(Landroid/widget/TabHost$TabSpec;)V

    .line 201
    const-string v7, "tab_record"

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->newTabSpec(Ljava/lang/String;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, v1, v11}, Landroid/widget/TabHost$TabSpec;->setIndicator(Ljava/lang/CharSequence;Landroid/graphics/drawable/Drawable;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v7, p0}, Landroid/widget/TabHost$TabSpec;->setContent(Landroid/widget/TabHost$TabContentFactory;)Landroid/widget/TabHost$TabSpec;

    move-result-object v7

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->addTab(Landroid/widget/TabHost$TabSpec;)V

    .line 203
    const-string v7, "tab_system"

    iput-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mCurTab:Ljava/lang/String;

    .line 204
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->mCurTab:Ljava/lang/String;

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->setCurrentTabByTag(Ljava/lang/String;)V

    .line 205
    new-instance v7, Lcom/android/internal/app/RingtonePickerActivity$2;

    invoke-direct {v7, p0}, Lcom/android/internal/app/RingtonePickerActivity$2;-><init>(Lcom/android/internal/app/RingtonePickerActivity;)V

    invoke-virtual {v5, v7}, Landroid/widget/TabHost;->setOnTabChangedListener(Landroid/widget/TabHost$OnTabChangeListener;)V

    .line 213
    return-void

    .line 161
    .end local v5    # "mTabHost":Landroid/widget/TabHost;
    :cond_6
    iget v7, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneActivityType:I

    const/4 v8, 0x2

    if-ne v7, v8, :cond_3

    .line 162
    invoke-virtual {p0}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x1040021

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v6

    goto/16 :goto_0
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 7
    .param p2, "arg1"    # Landroid/view/View;
    .param p3, "position"    # I
    .param p4, "id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView",
            "<*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    .prologue
    .line 612
    .local p1, "arg0":Landroid/widget/AdapterView;, "Landroid/widget/AdapterView<*>;"
    const-string v3, "lys"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onItemClick position =="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "id"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 613
    const-wide/16 v3, -0x1

    cmp-long v3, p4, v3

    if-nez v3, :cond_6

    .line 614
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    if-eqz v3, :cond_5

    .line 617
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v3, :cond_0

    const/4 v3, 0x1

    if-eq p3, v3, :cond_1

    :cond_0
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-nez v3, :cond_2

    .line 619
    :cond_1
    const-string v3, "lys"

    const-string v4, "onItemClick silentItemChecked == true"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 621
    const-wide/32 v3, 0xa98ac7

    iput-wide v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 622
    const/4 v3, 0x0

    iput-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 623
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    .line 624
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 625
    invoke-virtual {p0}, Lcom/android/internal/app/RingtonePickerActivity;->stopMediaPlayer()V

    .line 626
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v3}, Landroid/widget/AbsListView;->invalidateViews()V

    .line 694
    :goto_0
    return-void

    .line 628
    :cond_2
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v3, :cond_3

    if-nez p3, :cond_3

    .line 630
    const-string v3, "lys"

    const-string v4, "onItemClick defaultItemChecked == true"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 632
    const-wide/32 v3, 0x153158e

    iput-wide v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 633
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    iput-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 634
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 635
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    .line 660
    :cond_3
    :goto_1
    const-wide/16 v3, -0x1

    cmp-long v3, p4, v3

    if-eqz v3, :cond_4

    .line 662
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    invoke-interface {v3, p3}, Landroid/database/Cursor;->moveToPosition(I)Z

    .line 663
    const-string v3, "lys"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onItemClick position == "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "id =="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 664
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->toneCur:Landroid/database/Cursor;

    const-string v5, "_id"

    invoke-interface {v4, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v3, v4}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    .line 665
    .local v1, "newId":J
    iput-wide v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 666
    const-string v3, "lys"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " onItemClick mSelectedId=="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v5, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 667
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;

    invoke-static {v3, v1, v2}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 669
    .end local v1    # "newId":J
    :cond_4
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->listView:Landroid/widget/ListView;

    invoke-virtual {v3}, Landroid/widget/AbsListView;->invalidateViews()V

    .line 670
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->audioManager:Landroid/media/AudioManager;

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->mAudioFocusListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    const/4 v5, 0x3

    const/4 v6, 0x2

    invoke-virtual {v3, v4, v5, v6}, Landroid/media/AudioManager;->requestAudioFocus(Landroid/media/AudioManager$OnAudioFocusChangeListener;II)I

    .line 673
    invoke-virtual {p0}, Lcom/android/internal/app/RingtonePickerActivity;->stopMediaPlayer()V

    .line 674
    new-instance v3, Landroid/media/MediaPlayer;

    invoke-direct {v3}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    .line 676
    :try_start_0
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->mRingtoneManager:Landroid/media/RingtoneManager;

    invoke-virtual {v4}, Landroid/media/RingtoneManager;->inferStreamType()I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    .line 677
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    invoke-virtual {v3, p0, v4}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    .line 678
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Landroid/media/MediaPlayer;->prepare()V

    .line 679
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Landroid/media/MediaPlayer;->start()V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3

    goto/16 :goto_0

    .line 681
    :catch_0
    move-exception v0

    .line 683
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto/16 :goto_0

    .line 638
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :cond_5
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v3, :cond_3

    .line 640
    const-string v3, "lys"

    const-string v4, "onItemClick defaultItemChecked == true"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 642
    const-wide/32 v3, 0x153158e

    iput-wide v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    .line 643
    iget-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mUriForDefaultItem:Landroid/net/Uri;

    iput-object v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;

    .line 644
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 645
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    goto/16 :goto_1

    .line 650
    :cond_6
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z

    if-eqz v3, :cond_7

    .line 651
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z

    .line 652
    add-int/lit8 p3, p3, -0x1

    .line 655
    :cond_7
    iget-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z

    if-eqz v3, :cond_3

    .line 656
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z

    .line 657
    add-int/lit8 p3, p3, -0x1

    goto/16 :goto_1

    .line 684
    :catch_1
    move-exception v0

    .line 686
    .local v0, "e":Ljava/lang/SecurityException;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto/16 :goto_0

    .line 687
    .end local v0    # "e":Ljava/lang/SecurityException;
    :catch_2
    move-exception v0

    .line 689
    .local v0, "e":Ljava/lang/IllegalStateException;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto/16 :goto_0

    .line 690
    .end local v0    # "e":Ljava/lang/IllegalStateException;
    :catch_3
    move-exception v0

    .line 692
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    goto/16 :goto_0
.end method

.method protected onRestart()V
    .locals 2

    .prologue
    .line 321
    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    .line 322
    const-string v0, "lys"

    const-string v1, "PT onRestart called"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 323
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 336
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 337
    const-string v0, "lys"

    const-string v1, "PT onResume called"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 338
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 217
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 218
    const-string v0, "clicked_pos"

    iget-wide v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 219
    return-void
.end method

.method protected onStart()V
    .locals 2

    .prologue
    .line 328
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 329
    const-string v0, "lys"

    const-string v1, "PT onStart called next doQuery"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 331
    return-void
.end method

.method protected onStop()V
    .locals 2

    .prologue
    .line 351
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 352
    const-string v0, "lys"

    const-string v1, "PT onStop called"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 353
    invoke-virtual {p0}, Lcom/android/internal/app/RingtonePickerActivity;->stopMediaPlayer()V

    .line 354
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->audioManager:Landroid/media/AudioManager;

    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity;->mAudioFocusListener:Landroid/media/AudioManager$OnAudioFocusChangeListener;

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->abandonAudioFocus(Landroid/media/AudioManager$OnAudioFocusChangeListener;)I

    .line 355
    return-void
.end method

.method protected onUserLeaveHint()V
    .locals 0

    .prologue
    .line 343
    invoke-super {p0}, Landroid/app/Activity;->onUserLeaveHint()V

    .line 344
    invoke-virtual {p0}, Lcom/android/internal/app/RingtonePickerActivity;->stopMediaPlayer()V

    .line 345
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    .line 346
    return-void
.end method

.method stopMediaPlayer()V
    .locals 2

    .prologue
    .line 534
    const-string v0, "lys"

    const-string v1, "stopMediaPlayer()"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 535
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 536
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 537
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 538
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity;->mMediaPlayer:Landroid/media/MediaPlayer;

    .line 540
    :cond_0
    return-void
.end method
