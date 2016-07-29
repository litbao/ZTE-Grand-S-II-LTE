.class Lcyanogenmod/providers/CMSettings$NameValueCache;
.super Ljava/lang/Object;
.source "CMSettings.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcyanogenmod/providers/CMSettings;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "NameValueCache"
.end annotation


# static fields
.field private static final NAME_EQ_PLACEHOLDER:Ljava/lang/String; = "name=?"

.field private static final SELECT_VALUE:[Ljava/lang/String;


# instance fields
.field private mContentProvider:Landroid/content/IContentProvider;

.field private final mUri:Landroid/net/Uri;

.field private final mValues:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mValuesVersion:J

.field private final mVersionSystemProperty:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 54
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "value"

    aput-object v2, v0, v1

    sput-object v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->SELECT_VALUE:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Landroid/net/Uri;)V
    .locals 2
    .param p1, "versionSystemProperty"    # Ljava/lang/String;
    .param p2, "uri"    # Landroid/net/Uri;

    .prologue
    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValues:Ljava/util/HashMap;

    .line 60
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValuesVersion:J

    .line 63
    const/4 v0, 0x0

    iput-object v0, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mContentProvider:Landroid/content/IContentProvider;

    .line 66
    iput-object p1, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mVersionSystemProperty:Ljava/lang/String;

    .line 67
    iput-object p2, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mUri:Landroid/net/Uri;

    .line 68
    return-void
.end method

.method private lazyGetProvider(Landroid/content/ContentResolver;)Landroid/content/IContentProvider;
    .locals 2
    .param p1, "cr"    # Landroid/content/ContentResolver;

    .prologue
    .line 72
    monitor-enter p0

    .line 73
    :try_start_0
    iget-object v0, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mContentProvider:Landroid/content/IContentProvider;

    .line 74
    .local v0, "cp":Landroid/content/IContentProvider;
    if-nez v0, :cond_0

    .line 75
    iget-object v1, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mUri:Landroid/net/Uri;

    invoke-virtual {v1}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/content/ContentResolver;->acquireProvider(Ljava/lang/String;)Landroid/content/IContentProvider;

    move-result-object v0

    .end local v0    # "cp":Landroid/content/IContentProvider;
    iput-object v0, p0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mContentProvider:Landroid/content/IContentProvider;

    .line 77
    .restart local v0    # "cp":Landroid/content/IContentProvider;
    :cond_0
    monitor-exit p0

    .line 78
    return-object v0

    .line 77
    .end local v0    # "cp":Landroid/content/IContentProvider;
    :catchall_0
    move-exception v1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method


# virtual methods
.method public getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;
    .locals 16
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "userId"    # I

    .prologue
    .line 91
    invoke-static {}, Landroid/os/UserHandle;->myUserId()I

    move-result v3

    move/from16 v0, p3

    if-ne v0, v3, :cond_2

    const/4 v12, 0x1

    .line 92
    .local v12, "isSelf":Z
    :goto_0
    if-eqz v12, :cond_4

    .line 93
    move-object/from16 v0, p0

    iget-object v3, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mVersionSystemProperty:Ljava/lang/String;

    const-wide/16 v4, 0x0

    invoke-static {v3, v4, v5}, Landroid/os/SystemProperties;->getLong(Ljava/lang/String;J)J

    move-result-wide v14

    .line 96
    .local v14, "newValuesVersion":J
    monitor-enter p0

    .line 97
    :try_start_0
    move-object/from16 v0, p0

    iget-wide v4, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValuesVersion:J

    cmp-long v3, v4, v14

    if-eqz v3, :cond_0

    .line 103
    move-object/from16 v0, p0

    iget-object v3, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValues:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->clear()V

    .line 104
    move-object/from16 v0, p0

    iput-wide v14, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValuesVersion:J

    .line 107
    :cond_0
    move-object/from16 v0, p0

    iget-object v3, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValues:Ljava/util/HashMap;

    move-object/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 108
    move-object/from16 v0, p0

    iget-object v3, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValues:Ljava/util/HashMap;

    move-object/from16 v0, p2

    invoke-virtual {v3, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    monitor-exit p0

    .line 140
    .end local v14    # "newValuesVersion":J
    :cond_1
    :goto_1
    return-object v3

    .line 91
    .end local v12    # "isSelf":Z
    :cond_2
    const/4 v12, 0x0

    goto :goto_0

    .line 110
    .restart local v12    # "isSelf":Z
    .restart local v14    # "newValuesVersion":J
    :cond_3
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 116
    .end local v14    # "newValuesVersion":J
    :cond_4
    invoke-direct/range {p0 .. p1}, Lcyanogenmod/providers/CMSettings$NameValueCache;->lazyGetProvider(Landroid/content/ContentResolver;)Landroid/content/IContentProvider;

    move-result-object v2

    .line 118
    .local v2, "cp":Landroid/content/IContentProvider;
    const/4 v10, 0x0

    .line 120
    .local v10, "c":Landroid/database/Cursor;
    :try_start_1
    invoke-virtual/range {p1 .. p1}, Landroid/content/ContentResolver;->getPackageName()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mUri:Landroid/net/Uri;

    sget-object v5, Lcyanogenmod/providers/CMSettings$NameValueCache;->SELECT_VALUE:[Ljava/lang/String;

    const-string v6, "name=?"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/String;

    const/4 v8, 0x0

    aput-object p2, v7, v8

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-interface/range {v2 .. v9}, Landroid/content/IContentProvider;->query(Ljava/lang/String;Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Landroid/os/ICancellationSignal;)Landroid/database/Cursor;

    move-result-object v10

    .line 122
    if-nez v10, :cond_5

    .line 123
    const-string v3, "CMSettings"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Can\'t get key "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p2

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " from "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mUri:Landroid/net/Uri;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/os/RemoteException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 124
    const/4 v3, 0x0

    .line 140
    if-eqz v10, :cond_1

    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    goto :goto_1

    .line 110
    .end local v2    # "cp":Landroid/content/IContentProvider;
    .end local v10    # "c":Landroid/database/Cursor;
    .restart local v14    # "newValuesVersion":J
    :catchall_0
    move-exception v3

    :try_start_2
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v3

    .line 127
    .end local v14    # "newValuesVersion":J
    .restart local v2    # "cp":Landroid/content/IContentProvider;
    .restart local v10    # "c":Landroid/database/Cursor;
    :cond_5
    :try_start_3
    invoke-interface {v10}, Landroid/database/Cursor;->moveToNext()Z

    move-result v3

    if-eqz v3, :cond_7

    const/4 v3, 0x0

    invoke-interface {v10, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v13

    .line 128
    .local v13, "value":Ljava/lang/String;
    :goto_2
    monitor-enter p0
    :try_end_3
    .catch Landroid/os/RemoteException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 129
    :try_start_4
    move-object/from16 v0, p0

    iget-object v3, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mValues:Ljava/util/HashMap;

    move-object/from16 v0, p2

    invoke-virtual {v3, v0, v13}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 140
    if-eqz v10, :cond_6

    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    :cond_6
    move-object v3, v13

    goto :goto_1

    .line 127
    .end local v13    # "value":Ljava/lang/String;
    :cond_7
    const/4 v13, 0x0

    goto :goto_2

    .line 130
    .restart local v13    # "value":Ljava/lang/String;
    :catchall_1
    move-exception v3

    :try_start_5
    monitor-exit p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v3
    :try_end_6
    .catch Landroid/os/RemoteException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 136
    .end local v13    # "value":Ljava/lang/String;
    :catch_0
    move-exception v11

    .line 137
    .local v11, "e":Landroid/os/RemoteException;
    :try_start_7
    const-string v3, "CMSettings"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Can\'t get key "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p2

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " from "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, p0

    iget-object v5, v0, Lcyanogenmod/providers/CMSettings$NameValueCache;->mUri:Landroid/net/Uri;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v11}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 138
    const/4 v3, 0x0

    .line 140
    if-eqz v10, :cond_1

    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    goto/16 :goto_1

    .end local v11    # "e":Landroid/os/RemoteException;
    :catchall_2
    move-exception v3

    if-eqz v10, :cond_8

    invoke-interface {v10}, Landroid/database/Cursor;->close()V

    :cond_8
    throw v3
.end method
