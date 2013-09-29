NB. plotdwin

make_main_window=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'Plot')
box1=. gtk_vbox_new 0 0
'Cw Ch'=: 720 520
canvas=: glcanvas (Cw,Ch);coname''
PIdhwnd=: canvas

NB. create a menu-bar to hold the menus
menu_bar=. gtk_menu_bar_new ''
NB. mac look-and-feel, moved to the top of desktop
if. UNAME-:'Darwin' do. ((>libigemac),' ige_mac_menu_set_menu_bar >n x')&cd ::0: menu_bar end.

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Options')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, plotdemo_view=. gtk_menu_item_new_with_mnemonic <(gettext '_View Definition')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_clip=. gtk_menu_item_new_with_mnemonic <(gettext '_Clip')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_saveeps=. gtk_menu_item_new_with_mnemonic <(gettext '_Save EPS')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_savepdf=. gtk_menu_item_new_with_mnemonic <(gettext '_Save PDF')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_print=. gtk_menu_item_new_with_mnemonic <(gettext '_Print')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_slides=. gtk_menu_item_new_with_mnemonic <(gettext '_Slide Show')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_exit=. gtk_menu_item_new_with_mnemonic <(gettext 'E_xit')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_2D')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MJGRAPHICS=: gtk_menu_item_new_with_mnemonic <(gettext 'J Plot')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MLINE=: gtk_menu_item_new_with_mnemonic <(gettext 'Line Plots')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MLINES=: gtk_menu_item_new_with_mnemonic <(gettext 'Line Sampler')
gtk_menu_shell_append menu, MLINESTYLE=: gtk_menu_item_new_with_mnemonic <(gettext 'Line Options')
gtk_menu_shell_append menu, MLINE2Y=: gtk_menu_item_new_with_mnemonic <(gettext 'Line Second Y Axes')
gtk_menu_shell_append menu, MLINEPATTERN=: gtk_menu_item_new_with_mnemonic <(gettext 'Line Patterns')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MAREA=: gtk_menu_item_new_with_mnemonic <(gettext 'Area')
gtk_menu_shell_append menu, MDOT=: gtk_menu_item_new_with_mnemonic <(gettext 'Dot')
gtk_menu_shell_append menu, MMARKER=: gtk_menu_item_new_with_mnemonic <(gettext 'Marker')
gtk_menu_shell_append menu, MSYMBOL=: gtk_menu_item_new_with_mnemonic <(gettext 'Symbol')
gtk_menu_shell_append menu, MPOLAR=: gtk_menu_item_new_with_mnemonic <(gettext 'Polar')
gtk_menu_shell_append menu, MSTICK=: gtk_menu_item_new_with_mnemonic <(gettext 'Stick')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MBAR=: gtk_menu_item_new_with_mnemonic <(gettext 'Bar')
gtk_menu_shell_append menu, MBARS=: gtk_menu_item_new_with_mnemonic <(gettext 'Bar Sampler')
gtk_menu_shell_append menu, MHIST=: gtk_menu_item_new_with_mnemonic <(gettext 'Histogram')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MERRORBAR=: gtk_menu_item_new_with_mnemonic <(gettext 'Error Bar')
gtk_menu_shell_append menu, MHILO=: gtk_menu_item_new_with_mnemonic <(gettext 'HiLo')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MPIE=: gtk_menu_item_new_with_mnemonic <(gettext 'Pie')
gtk_menu_shell_append menu, MPIEM=: gtk_menu_item_new_with_mnemonic <(gettext 'Pie Multi')
gtk_menu_shell_append menu, MRADAR=: gtk_menu_item_new_with_mnemonic <(gettext 'Radar')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MPOLY=: gtk_menu_item_new_with_mnemonic <(gettext 'Poly')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MCONTOUR=: gtk_menu_item_new_with_mnemonic <(gettext 'Contour')
gtk_menu_shell_append menu, MDENSITY=: gtk_menu_item_new_with_mnemonic <(gettext 'Density')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_3D')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MLINE3D=: gtk_menu_item_new_with_mnemonic <(gettext 'Line')
gtk_menu_shell_append menu, MSTICK3D=: gtk_menu_item_new_with_mnemonic <(gettext 'Stick')
gtk_menu_shell_append menu, MWIRE=: gtk_menu_item_new_with_mnemonic <(gettext 'Wire')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MSURFACE=: gtk_menu_item_new_with_mnemonic <(gettext 'Surface')
gtk_menu_shell_append menu, MSURFACEREV=: gtk_menu_item_new_with_mnemonic <(gettext 'Surface of Revolution')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MSURFACES=: gtk_menu_item_new_with_mnemonic <(gettext 'Surface Sampler')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MSPHERE=: gtk_menu_item_new_with_mnemonic <(gettext 'Sphere')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MSOLID=: gtk_menu_item_new_with_mnemonic <(gettext 'Solids')
gtk_menu_shell_append menu, MSTELLATE=: gtk_menu_item_new_with_mnemonic <(gettext 'Stellates')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Multi')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MMULTI1=: gtk_menu_item_new_with_mnemonic <(gettext 'Simple Multiplot')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MMULTI2=: gtk_menu_item_new_with_mnemonic <(gettext 'Y Grouped Multiplot')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MMULTI3=: gtk_menu_item_new_with_mnemonic <(gettext 'XY Grouped Multiplot')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MMULTI4=: gtk_menu_item_new_with_mnemonic <(gettext 'Mixed Multiplot')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Styles')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MSAMPLER=: gtk_menu_item_new_with_mnemonic <(gettext 'Plot Sampler')
gtk_menu_shell_append menu, MRULE=: gtk_menu_item_new_with_mnemonic <(gettext 'Rule Sampler')
gtk_menu_shell_append menu, MKEYS=: gtk_menu_item_new_with_mnemonic <(gettext 'Key Styles')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MCOLOR1=: gtk_menu_item_new_with_mnemonic <(gettext 'Style 1')
gtk_menu_shell_append menu, MCOLOR2=: gtk_menu_item_new_with_mnemonic <(gettext 'Style 2')
gtk_menu_shell_append menu, MCOLOR3=: gtk_menu_item_new_with_mnemonic <(gettext 'Style 3')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MLOGS=: gtk_menu_item_new_with_mnemonic <(gettext 'Log Examples')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Gallery')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MLINE1=: gtk_menu_item_new_with_mnemonic <(gettext 'Line 1')
gtk_menu_shell_append menu, MLINE2=: gtk_menu_item_new_with_mnemonic <(gettext 'Line 2')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MCURVEFIT=: gtk_menu_item_new_with_mnemonic <(gettext 'Curve Fitting')
gtk_menu_shell_append menu, MLEGENDRE=: gtk_menu_item_new_with_mnemonic <(gettext 'Legendre')
gtk_menu_shell_append menu, MPRIMERACE=: gtk_menu_item_new_with_mnemonic <(gettext 'Prime Race')
gtk_menu_shell_append menu, MCONTOUR1=: gtk_menu_item_new_with_mnemonic <(gettext 'Contour vs Density')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MPAT1=: gtk_menu_item_new_with_mnemonic <(gettext 'Patterns 1')
gtk_menu_shell_append menu, MPAT2=: gtk_menu_item_new_with_mnemonic <(gettext 'Patterns 2')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, MWIRES=: gtk_menu_item_new_with_mnemonic <(gettext 'Wire')
gtk_menu_shell_append menu, MGAMMA=: gtk_menu_item_new_with_mnemonic <(gettext 'Gamma Function')
gtk_menu_shell_append menu, MDRUM=: gtk_menu_item_new_with_mnemonic <(gettext 'Drum')
gtk_menu_shell_append menu, MSURFACE1=: gtk_menu_item_new_with_mnemonic <(gettext 'Surface')

gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Help')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

gtk_menu_shell_append menu, MF12=. gtk_menu_item_new_with_label <(gettext 'F12 Next')
gtk_menu_shell_append menu, MF12S=. gtk_menu_item_new_with_label <(gettext 'Shift F12 Previous')
gtk_menu_shell_append menu, gtk_separator_menu_item_new''
gtk_menu_shell_append menu, plotdemo_about=. gtk_menu_item_new_with_mnemonic <(gettext '_About')

gtk_container_add window, box1
gtk_box_pack_start box1, menu_bar, 0 0 2
gtk_box_pack_start box1, canvas, 1 1 0    NB. take up remaining space

consig window;'destroy';'plotdemo_destroy'         NB. window destroyed
consig3 window;'key-press-event';'plotdemo_ps_char'     NB. key down

NB. ---------------------------------------------------------
NB. menu
consig plotdemo_view;'activate';'plotdemo_view_button'
consig plotdemo_clip;'activate';'plotdemo_clip_button'
consig plotdemo_saveeps;'activate';'plotdemo_saveeps_button'
consig plotdemo_savepdf;'activate';'plotdemo_savepdf_button'
consig plotdemo_print;'activate';'plotdemo_print_button'
consig plotdemo_slides;'activate';'plotdemo_slides_button'
consig plotdemo_exit;'activate';'plotdemo_exit_button'

consig MJGRAPHICS;'activate';'plotdemo_MJGRAPHICS_button'
consig MLINE;'activate';'plotdemo_MLINE_button'
consig MLINES;'activate';'plotdemo_MLINES_button'
consig MLINESTYLE;'activate';'plotdemo_MLINESTYLE_button'
consig MLINE2Y;'activate';'plotdemo_MLINE2Y_button'
consig MLINEPATTERN;'activate';'plotdemo_MLINEPATTERN_button'
consig MAREA;'activate';'plotdemo_MAREA_button'
consig MDOT;'activate';'plotdemo_MDOT_button'
consig MMARKER;'activate';'plotdemo_MMARKER_button'
consig MSYMBOL;'activate';'plotdemo_MSYMBOL_button'
consig MPOLAR;'activate';'plotdemo_MPOLAR_button'
consig MSTICK;'activate';'plotdemo_MSTICK_button'
consig MBAR;'activate';'plotdemo_MBAR_button'
consig MBARS;'activate';'plotdemo_MBARS_button'
consig MHIST;'activate';'plotdemo_MHIST_button'
consig MERRORBAR;'activate';'plotdemo_MERRORBAR_button'
consig MHILO;'activate';'plotdemo_MHILO_button'
consig MPIE;'activate';'plotdemo_MPIE_button'
consig MPIEM;'activate';'plotdemo_MPIEM_button'
consig MRADAR;'activate';'plotdemo_MRADAR_button'
consig MPOLY;'activate';'plotdemo_MPOLY_button'
consig MCONTOUR;'activate';'plotdemo_MCONTOUR_button'
consig MDENSITY;'activate';'plotdemo_MDENSITY_button'
consig MLINE3D;'activate';'plotdemo_MLINE3D_button'
consig MSTICK3D;'activate';'plotdemo_MSTICK3D_button'
consig MWIRE;'activate';'plotdemo_MWIRE_button'
consig MSURFACE;'activate';'plotdemo_MSURFACE_button'
consig MSURFACEREV;'activate';'plotdemo_MSURFACEREV_button'
consig MSURFACES;'activate';'plotdemo_MSURFACES_button'
consig MSPHERE;'activate';'plotdemo_MSPHERE_button'
consig MSOLID;'activate';'plotdemo_MSOLID_button'
consig MSTELLATE;'activate';'plotdemo_MSTELLATE_button'
consig MMULTI1;'activate';'plotdemo_MMULTI1_button'
consig MMULTI2;'activate';'plotdemo_MMULTI2_button'
consig MMULTI3;'activate';'plotdemo_MMULTI3_button'
consig MMULTI4;'activate';'plotdemo_MMULTI4_button'
consig MSAMPLER;'activate';'plotdemo_MSAMPLER_button'
consig MRULE;'activate';'plotdemo_MRULE_button'
consig MKEYS;'activate';'plotdemo_MKEYS_button'
consig MCOLOR1;'activate';'plotdemo_MCOLOR1_button'
consig MCOLOR2;'activate';'plotdemo_MCOLOR2_button'
consig MCOLOR3;'activate';'plotdemo_MCOLOR3_button'
consig MLOGS;'activate';'plotdemo_MLOGS_button'
consig MLINE1;'activate';'plotdemo_MLINE1_button'
consig MLINE2;'activate';'plotdemo_MLINE2_button'
consig MCURVEFIT;'activate';'plotdemo_MCURVEFIT_button'
consig MLEGENDRE;'activate';'plotdemo_MLEGENDRE_button'
consig MPRIMERACE;'activate';'plotdemo_MPRIMERACE_button'
consig MCONTOUR1;'activate';'plotdemo_MCONTOUR1_button'
consig MPAT1;'activate';'plotdemo_MPAT1_button'
consig MPAT2;'activate';'plotdemo_MPAT2_button'
consig MWIRES;'activate';'plotdemo_MWIRES_button'
consig MGAMMA;'activate';'plotdemo_MGAMMA_button'
consig MDRUM;'activate';'plotdemo_MDRUM_button'
consig MSURFACE1;'activate';'plotdemo_MSURFACE1_button'
consig MF12;'activate';'plotdemo_next_button'
consig MF12S;'activate';'plotdemo_prev_button'
consig plotdemo_about;'activate';'plotdemo_about_button'
)

NB. =========================================================

PLOTALL=: 'D', each PLOTNAMES
