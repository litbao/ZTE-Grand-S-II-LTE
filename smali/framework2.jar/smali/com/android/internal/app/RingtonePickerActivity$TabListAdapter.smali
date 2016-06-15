.class Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;
.super Landroid/widget/SimpleCursorAdapter;
.source "RingtonePickerActivity.java"

# interfaces
.implements Landroid/widget/SectionIndexer;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/app/RingtonePickerActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "TabListAdapter"
.end annotation


# instance fields
.field private mIdIdx:I

.field private mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

.field private mTitleIdx:I

.field private radio:Landroid/widget/RadioButton;

.field private radioDefault:Landroid/widget/RadioButton;

.field private radioSilent:Landroid/widget/RadioButton;

.field final synthetic this$0:Lcom/android/internal/app/RingtonePickerActivity;


# direct methods
.method public constructor <init>(Lcom/android/internal/app/RingtonePickerActivity;Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V
    .locals 6
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "layout"    # I
    .param p4, "c"    # Landroid/database/Cursor;
    .param p5, "from"    # [Ljava/lang/String;
    .param p6, "to"    # [I

    .prologue
    .line 707
    iput-object p1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    move-object v0, p0

    move-object v1, p2

    move v2, p3

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    .line 708
    invoke-direct/range {v0 .. v5}, Landroid/widget/SimpleCursorAdapter;-><init>(Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V

    .line 709
    const-string v0, "title"

    invoke-interface {p4, v0}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mTitleIdx:I

    .line 710
    const-string v0, "_id"

    invoke-interface {p4, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIdIdx:I

    .line 711
    new-instance v0, Lcom/android/internal/app/RingtoneAlphabetIndexer;

    iget v1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mTitleIdx:I

    invoke-virtual {p1}, Landroid/view/ContextThemeWrapper;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x10404bf

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, p4, v1, v2}, Lcom/android/internal/app/RingtoneAlphabetIndexer;-><init>(Landroid/database/Cursor;ILjava/lang/CharSequence;)V

    iput-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

    .line 713
    return-void
.end method


# virtual methods
.method public bindView(Landroid/view/View;Landroid/content/Context;Landroid/database/Cursor;)V
    .locals 10
    .param p1, "view"    # Landroid/view/View;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "cursor"    # Landroid/database/Cursor;

    .prologue
    const v7, 0x10202c5

    const/4 v5, 0x1

    const/4 v6, 0x0

    .line 718
    invoke-super {p0, p1, p2, p3}, Landroid/widget/SimpleCursorAdapter;->bindView(Landroid/view/View;Landroid/content/Context;Landroid/database/Cursor;)V

    .line 719
    const v4, 0x1020016

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 720
    .local v3, "tv":Landroid/widget/TextView;
    iget v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mTitleIdx:I

    invoke-interface {p3, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 721
    .local v2, "name":Ljava/lang/String;
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 722
    iget v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIdIdx:I

    invoke-interface {p3, v4}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    .line 723
    .local v0, "id":J
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->mHasSilentItem:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$100(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 725
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->silentView:Landroid/view/View;
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$200(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/RadioButton;

    iput-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioSilent:Landroid/widget/RadioButton;

    .line 726
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$300(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 727
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioSilent:Landroid/widget/RadioButton;

    invoke-virtual {v4, v5}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 732
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->mHasDefaultItem:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$400(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 734
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->defaultView:Landroid/view/View;
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$500(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/RadioButton;

    iput-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioDefault:Landroid/widget/RadioButton;

    .line 735
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$600(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 736
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioDefault:Landroid/widget/RadioButton;

    invoke-virtual {v4, v5}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 741
    :cond_1
    :goto_1
    invoke-virtual {p1, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/RadioButton;

    iput-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radio:Landroid/widget/RadioButton;

    .line 742
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->silentItemChecked:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$300(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-nez v4, :cond_5

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->defaultItemChecked:Z
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$600(Lcom/android/internal/app/RingtonePickerActivity;)Z

    move-result v4

    if-nez v4, :cond_5

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$700(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/net/Uri;

    move-result-object v4

    if-eqz v4, :cond_5

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->mSelectedUri:Landroid/net/Uri;
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$700(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {v4}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->BaseUri:Landroid/net/Uri;
    invoke-static {v7}, Lcom/android/internal/app/RingtonePickerActivity;->access$800(Lcom/android/internal/app/RingtonePickerActivity;)Landroid/net/Uri;

    move-result-object v7

    invoke-virtual {v7}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-ltz v4, :cond_5

    .line 744
    iget-object v7, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radio:Landroid/widget/RadioButton;

    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    # getter for: Lcom/android/internal/app/RingtonePickerActivity;->mSelectedId:J
    invoke-static {v4}, Lcom/android/internal/app/RingtonePickerActivity;->access$900(Lcom/android/internal/app/RingtonePickerActivity;)J

    move-result-wide v8

    cmp-long v4, v0, v8

    if-nez v4, :cond_4

    move v4, v5

    :goto_2
    invoke-virtual {v7, v4}, Landroid/widget/CompoundButton;->setChecked(Z)V

    .line 749
    :goto_3
    return-void

    .line 729
    :cond_2
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioSilent:Landroid/widget/RadioButton;

    invoke-virtual {v4, v6}, Landroid/widget/CompoundButton;->setChecked(Z)V

    goto :goto_0

    .line 738
    :cond_3
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radioDefault:Landroid/widget/RadioButton;

    invoke-virtual {v4, v6}, Landroid/widget/CompoundButton;->setChecked(Z)V

    goto :goto_1

    :cond_4
    move v4, v6

    .line 744
    goto :goto_2

    .line 747
    :cond_5
    iget-object v4, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->radio:Landroid/widget/RadioButton;

    invoke-virtual {v4, v6}, Landroid/widget/CompoundButton;->setChecked(Z)V

    goto :goto_3
.end method

.method public getPositionForSection(I)I
    .locals 5
    .param p1, "section"    # I

    .prologue
    const/4 v2, 0x0

    .line 762
    const-string v1, "lys"

    const-string v3, "PT getPositionForSection()"

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 763
    invoke-virtual {p0}, Landroid/widget/CursorAdapter;->getCursor()Landroid/database/Cursor;

    move-result-object v0

    .line 764
    .local v0, "cursor":Landroid/database/Cursor;
    if-nez v0, :cond_0

    .line 773
    :goto_0
    return v2

    .line 768
    :cond_0
    const-string v3, "lys"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPositionForSection mIndexer == null"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

    if-nez v1, :cond_1

    const/4 v1, 0x1

    :goto_1
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 769
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    invoke-virtual {v1}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_2

    .line 770
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

    invoke-virtual {v1, p1}, Landroid/widget/AlphabetIndexer;->getPositionForSection(I)I

    move-result v2

    goto :goto_0

    :cond_1
    move v1, v2

    .line 768
    goto :goto_1

    .line 772
    :cond_2
    iget-object v1, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->this$0:Lcom/android/internal/app/RingtonePickerActivity;

    invoke-virtual {v1}, Landroid/app/Activity;->finish()V

    goto :goto_0
.end method

.method public getSectionForPosition(I)I
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 780
    const/4 v0, 0x0

    return v0
.end method

.method public getSections()[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 786
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

    if-eqz v0, :cond_0

    .line 787
    iget-object v0, p0, Lcom/android/internal/app/RingtonePickerActivity$TabListAdapter;->mIndexer:Lcom/android/internal/app/RingtoneAlphabetIndexer;

    invoke-virtual {v0}, Landroid/widget/AlphabetIndexer;->getSections()[Ljava/lang/Object;

    move-result-object v0

    .line 789
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public newView(Landroid/content/Context;Landroid/database/Cursor;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "cursor"    # Landroid/database/Cursor;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    .line 754
    invoke-super {p0, p1, p2, p3}, Landroid/widget/ResourceCursorAdapter;->newView(Landroid/content/Context;Landroid/database/Cursor;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 755
    .local v0, "v":Landroid/view/View;
    return-object v0
.end method
