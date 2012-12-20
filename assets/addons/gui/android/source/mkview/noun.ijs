NB. enumeration. do _not_ sort content of this noun
ralativelayoutrule=: <;._2 (0 : 0)
toLefTOf
toRightOf
above
below
alignBaseline
alignLeft
alignTop
alignRight
alignBottom
alignParentLeft
alignParentTop
alignParentRight
alignParentBottom
centerInParent
centerHorizontal
centerVertical
)

layoutparams=: <;._2 (0 : 0)
android:layout_above
android:layout_alignBaseline
android:layout_alignBottom
android:layout_alignLeft
android:layout_alignParentBottom
android:layout_alignParentLeft
android:layout_alignParentRight
android:layout_alignParentTop
android:layout_alignRight
android:layout_alignTop
android:layout_alignWithParentIfMissing
android:layout_below
android:layout_centerHorizontal
android:layout_centerInParent
android:layout_centerVertical
android:layout_column
android:layout_columnSpan
android:layout_gravity
android:layout_height
android:layout_margin
android:layout_marginBottom
android:layout_marginLeft
android:layout_marginRight
android:layout_marginTop
android:layout_row
android:layout_rowSpan
android:layout_scale
android:layout_span
android:layout_toLeftOf
android:layout_toRightOf
android:layout_weight
android:layout_width
android:layout_x
android:layout_y
)

addrule=: <;._2 (0 : 0)
android:layout_alignBaseline
android:layout_alignParentBottom
android:layout_alignParentLeft
android:layout_alignParentRight
android:layout_alignParentTop
android:layout_alignWithParentIfMissing
android:layout_centerHorizontal
android:layout_centerInParent
android:layout_centerVertical
)

addrule2=: <;._2 (0 : 0)
android:layout_above
android:layout_alignBottom
android:layout_alignLeft
android:layout_alignRight
android:layout_alignTop
android:layout_below
android:layout_toLeftOf
android:layout_toRightOf
)

viewgroupatt=: (<@trim1;._1);._2 (0 : 0)
%android:addStatesFromChildren  %
%android:alwaysDrawnWithCache   %
%android:animateLayoutChanges   %setLayoutTransition
%android:animationCache         %
%android:clipChildren           %setClipChildren
%android:clipToPadding          %setClipToPadding
%android:descendantFocusability %
%android:layoutAnimation        %
%android:persistentDrawingCache %
)

viewatt=: (<@trim1;._1);._2 (0 : 0)
%android:alpha                              %setAlpha(float)
%android:background                         %setBackgroundResource(int)
%android:clickable                          %setClickable(boolean)
%android:contentDescription                 %setContentDescription
%android:drawingCacheQuality                %setDrawingCacheQuality(int)
%android:duplicateParentState               %
%android:fadeScrollbars                     %setScrollbarFadingEnabled(boolean)
%android:fadingEdgeLength                   %setVerticalFadingEdgeLength()
%android:filterTouchesWhenObscured          %setFilterTouchesWhenObscured
%android:fitsSystemWindows                  %setFitsSystemWindows(boolean)
%android:focusable                          %setFocusable(boolean)
%android:focusableInTouchMode               %setFocusableInTouchMode(boolean)
%android:hapticFeedbackEnabled              %setHapticFeedbackEnabled(boolean)
%android:id                                 %setId(int)
%android:importantForAccessibility          %setImportantForAccessibility(int)
%android:isScrollContainer                  %setScrollContainer(boolean)
%android:keepScreenOn                       %setKeepScreenOn(boolean)
%android:layerType                          %setLayerType(int,Paint)
%android:longClickable                      %setLongClickable(boolean)
%android:minHeight                          %setMinimumHeight(int)
%android:minWidth                           %setMinimumWidth(int)
%android:nextFocusDown                      %setNextFocusDownId(int)
%android:nextFocusForward                   %setNextFocusForwardId(int)
%android:nextFocusLeft                      %setNextFocusLeftId(int)
%android:nextFocusRight                     %setNextFocusRightId(int)
%android:nextFocusUp                        %setNextFocusUpId(int)
%android:onClick                            %
%android:padding                            %setPadding(int,int,int,int)
%android:paddingBottom                      %setPadding(int,int,int,int)
%android:paddingLeft                        %setPadding(int,int,int,int)
%android:paddingRight                       %setPadding(int,int,int,int)
%android:paddingTop                         %setPadding(int,int,int,int)
%android:requiresFadingEdge                 %setVerticalFadingEdgeEnabled
%android:rotation                           %setRotation(float)
%android:rotationX                          %setRotationX(float)
%android:rotationY                          %setRotationY(float)
%android:saveEnabled                        %setSaveEnabled(boolean)
%android:scaleX                             %setScaleX(float)
%android:scaleY                             %setScaleY(float)
%android:scrollX                            %
%android:scrollY                            %
%android:scrollbarAlwaysDrawHorizontalTrack %
%android:scrollbarAlwaysDrawVerticalTrack   %
%android:scrollbarDefaultDelayBeforeFade    %setScrollBarDefaultDelayBeforeFade
%android:scrollbarFadeDuration              %setScrollBarFadeDuration(int)
%android:scrollbarSize                      %setScrollBarSize(int)
%android:scrollbarStyle                     %setScrollBarStyle(int)
%android:scrollbarThumbHorizontal           %
%android:scrollbarThumbVertical             %
%android:scrollbarTrackHorizontal           %
%android:scrollbarTrackVertical             %
%android:scrollbars                         %
%android:soundEffectsEnabled                %setSoundEffectsEnabled(boolean)
%android:tag                                %
%android:transformPivotX                    %setPivotX(float)
%android:transformPivotY                    %setPivotY(float)
%android:translationX                       %setTranslationX(float)
%android:translationY                       %setTranslationY(float)
%android:visibility                         %setVisibility(int)
)

layoutparams=: <;._2 (0 : 0)
android.view.ViewGroup$LayoutParams
android.view.ViewGroup$MarginLayoutParams
android.view.WindowManager$LayoutParams
android.widget.AbsListView$LayoutParams
android.widget.AbsoluteLayout$LayoutParams
android.widget.FrameLayout$LayoutParams
android.widget.Gallery$LayoutParams
android.widget.LinearLayout$LayoutParams
android.widget.RadioGroup$LayoutParams
android.widget.RelativeLayout$LayoutParams
android.widget.TableLayout$LayoutParams
android.widget.TableRow$LayoutParams
)
