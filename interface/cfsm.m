function cfsm
%Z. Li
%July, 2010
%Preprocessor screen of advance input for finite strip analysis
%
%general
global fig screen prop node elem lengths curve shapes clas springs constraints GBTcon BC m_all neigs version screen zoombtn panbtn rotatebtn
%output from pre2
global subfig ed_prop ed_node ed_elem ed_lengths axestop screen flags modeflag ed_springs ed_constraints
%output from template
global prop node elem lengths springs constraints h_tex b1_tex d1_tex q1_tex b2_tex d2_tex q2_tex r1_tex r2_tex r3_tex r4_tex t_tex C Z kipin Nmm axestemp subfig
%output from propout and loading
global A xcg zcg Ixx Izz Ixz thetap I11 I22 Cw J outfy_tex unsymm restrained Bas_Adv scale_w Xs Ys w scale_tex_w outPedit outMxxedit outMzzedit outM11edit outM22edit outTedit outBedit outL_Tedit outx_Tedit Pcheck Mxxcheck Mzzcheck M11check M22check Tcheck screen axesprop axesstres scale_tex maxstress_tex minstress_tex
%output from boundary condition (Bound. Cond.)
global ed_m ed_neigs solutiontype togglesignature togglegensolution popup_BC toggleSolution Plengths Pm_all Hlengths Hm_all HBC PBC subfig lengthindex axeslongtshape longitermindex hcontainershape txt_longterm len_cur len_longterm longshape_cur jScrollPane_edm jViewPort_edm jEditbox_edm hjScrollPane_edm
%output from cFSM
global toggleglobal toggledist togglelocal toggleother ed_global ed_dist ed_local ed_other NatBasis ModalBasis toggleCouple popup_load axesoutofplane axesinplane axes3d lengthindex modeindex spaceindex longitermindex b_v_view modename spacename check_3D cutface_edit len_cur mode_cur space_cur longterm_cur modes SurfPos scale twod threed undef scale_tex
%output from compareout
global pathname filename pathnamecell filenamecell propcell nodecell elemcell lengthscell curvecell clascell shapescell springscell constraintscell GBTconcell solutiontypecell BCcell m_allcell filedisplay files fileindex modes modeindex mmodes mmodeindex lengthindex axescurve togglelfvsmode togglelfvslength curveoption ifcheck3d minopt logopt threed undef axes2dshapelarge togglemin togglelog modestoplot_tex filetoplot_tex modestoplot_title filetoplot_title checkpatch len_plot lf_plot mode_plot SurfPos cutsurf_tex filename_plot len_cur scale_tex mode_cur mmode_cur file_cur xmin_tex xmax_tex ymin_tex ymax_tex filetoplot_tex screen popup_plot filename_title2 clasopt popup_classify times_classified toggleclassify classification_results plength_cur pfile_cur togglepfiles toggleplength mlengthindex mfileindex axespart_title axes2dshape axes3dshape axesparticipation axescurvemode  modedisplay modestoplot_tex
%

clf
name=['CUFSM v',version,' -- Finite Strip Pre-Processor -- constrained Finite Strip Method Input'];
set(fig,'Name',name);

%-------------------------------------------------------------------------
screen=3;
commandbar;
%
modeflag=[0 0 0 0];
if max(GBTcon.glob)==1
    modeflag(1)=1;
end
if max(GBTcon.dist)==1
    modeflag(2)=1;
end
if max(GBTcon.local)==1
    modeflag(3)=1;
end
if max(GBTcon.other)==1
    modeflag(4)=1;
end

%initial values
lengthindex=1;
longitermindex=1;
SurfPos=1/2;%cut surface position along the length for 2D view y/L
scale=1;
modeindex=1;
spaceindex=1;
twod=1;
threed=0;
undef=1;

% Upper part 
box=uicontrol(fig,...
    'Style','frame','units','normalized',...
    'Position',[0.0 0.9 1 0.05]);
title_box=uicontrol(fig,...
    'Style','text','units','normalized',...
    'HorizontalAlignment','center',...
    'FontName','Arial','FontSize',13,...
    'Position',[0.01 0.91 0.98 0.03],...
    'String','Constrained Finite Strip Method (cFSM)');
%--------------------------------------------------------------------------

%--------------------------------------------------------------------
%Modal/GBT Constraints
box=uicontrol(fig,...
    'Style','frame','units','normalized',...
    'Position',[0.0 0.52 1 0.38]);
%Natural/Modal basis toggle
title_basis=uicontrol(fig,...
    'Style','text','units','normalized',...
    'HorizontalAlignment','Left','fontweight','b',...
    'FontName','Arial','FontSize',13,...
    'Position',[0.1 0.85 0.25 0.04],...
    'String','Basis for cFSM');
NatBasis=uicontrol(fig,...
    'Style','radio','units','normalized',...
    'Position',[0.14 0.80 0.15 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Natural basis (ST)',...
    'Value',0,...
    'CallBack',[...
    'cfsm_cb(306);']);
ModalBasis=uicontrol(fig,...
    'Style','radio','units','normalized',...
    'Position',[0.14 0.76 0.15 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Modal basis (ST)',...
    'Value',1,...
    'CallBack',[...
    'cfsm_cb(307);']);
toggleCouple=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.51 0.76 0.15 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Coupled',...
    'Value',0,...
    'Callback',[...
    'cfsm_cb(308);']); %coupleFlags
popup_load=uicontrol(fig,...
    'Style','popup','units','normalized',...
    'Position',[0.29 0.76 0.20 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Orth. under uniform load|Orth. under applied load',...
    'Value',1,...
    'Callback',[...
    'cfsm_cb(307);']);
%Handle GBT basis by GBTcon.ospace,GBTcon.orth, and GBTcon.couple
if GBTcon.orth==1
    set(NatBasis,'Value',1);
    set(ModalBasis,'Value',0);
elseif GBTcon.orth==2
    set(NatBasis,'Value',0);
    set(ModalBasis,'Value',1);
    set(popup_load,'Value',1);
elseif GBTcon.orth==3
    set(NatBasis,'Value',0);
    set(ModalBasis,'Value',1);
    set(popup_load,'Value',2);
end
if GBTcon.couple==1
    set(toggleCouple,'Value',0);
elseif GBTcon.couple==2
    set(toggleCouple,'Value',1);
end

%Activate cFSM
activate_GBTcon=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.01 0.705 0.08 0.05],...
    'FontName','Arial','FontSize',12,...
    'String','On/Off',...
    'Tooltip','Turn on the constrained Finite Strip Method (cFSM)',...
    'Callback',[...
    'cfsm_cb(300);']);
toggletxt=uicontrol(fig,...
    'Style','text','units','normalized',...
    'Position',[0.1 0.70 0.12 0.04],...
    'HorizontalAlignment','Left','fontweight','b',...
    'FontName','Arial','FontSize',12,...
    'String','Base vectors');

toggleglobal=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.14 0.65 0.12 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Global',...
    'Value',modeflag(1),...
    'Callback',[...
    'cfsm_cb(301);']);
toggledist=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.14 0.61 0.12 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Distortional',...
    'Value',modeflag(2),...
    'Callback',[...
    'cfsm_cb(302);']);
togglelocal=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.14 0.57 0.12 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Local',...
    'Value',modeflag(3),...
    'Callback',[...
    'cfsm_cb(303);']);
toggleother=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.14 0.53 0.12 0.04],...
    'FontName','Arial','FontSize',12,...
    'String','Other(ST)',...
    'Value',modeflag(4),...
    'Callback',[...
    'cfsm_cb(304);']);
ed_global=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
    'String',num2str(GBTcon.glob),...
    'Position',[0.26 0.65 0.5 0.04],...
    'Max',1);
ed_dist=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
    'String',num2str(GBTcon.dist),...
    'Position',[0.26 0.61 0.5 0.04],...
    'Max',1);
ed_local=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
    'String',num2str(GBTcon.local),...
    'Position',[0.26 0.57 0.5 0.04],...
    'Max',1);
ed_other=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
    'String',num2str(GBTcon.other),...
    'Position',[0.26 0.53 0.5 0.04],...
    'Max',1);
%------------------------------------------------------------------
%
%viewer of the base vectors
box=uicontrol(fig,...
    'Style','frame','units','normalized',...
    'Position',[0.0 0.44 1 0.08]);
title_box=uicontrol(fig,...
    'Style','text','units','normalized',...
    'HorizontalAlignment','center',...    
    'FontName','Arial','FontSize',13,...
    'Position',[0.01 0.485 0.98 0.03],...
    'String','Modal vector viewer');
%
%define axes shapes that will be used for plotting
axesoutofplane=axes('Units','normalized','Position',[0.03 0.08 0.3 0.32],'visible','off');
axesinplane=axes('Units','normalized','Position',[0.35 0.08 0.3 0.32],'visible','off');
axes3d=axes('Units','normalized','Position',[0.67 0.08 0.3 0.32],'visible','off');
%
%
%base vectors for the specified length
m_a=m_all{lengthindex};
totalm=length(m_a);
ndof_m=4*length(node(:,1));
modes=[];modename=[];
modes=(1:1:totalm*ndof_m);
%since GBTcon might not be turned on, but we still need to count the mode
%inside each space.
[elprop,m_node,m_elem,node_prop,nmno,ncno,nsno,ndm,nlm,DOFperm]=base_properties(node,elem);
ngm=4;nom=2*(length(node(:,1))-1);
for i=1:1:length(modes)
    j=rem(i,ndof_m);
    if j==0  %O
        modename{i}=['O',num2str(ndof_m-ngm-ndm-nlm)];
    elseif j>0&j<=ngm
        modename{i}=['G',num2str(j)];
    elseif j>ngm&j<=(ngm+ndm)
        modename{i}=['D',num2str(j-ngm)];
    elseif j>(ngm+ndm)&j<=(ngm+ndm+nlm)
        modename{i}=['L',num2str(j-ngm-ndm)];
    elseif j>(ngm+ndm+nlm)
        modename{i}=['O',num2str(j-ngm-ndm-nlm)];
    end
end
spacename{1}='Global';
spacename{2}='Distortional';
spacename{3}='Local';
spacename{4}='Other';

%Setup frame around the bottom controls
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.0 0.0 1.0 0.071]);
viewGBTcon=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.67 0.445 0.07 0.07],...
    'FontName','Arial','FontSize',12,...
     'String','View',...
     'Tooltip','Click to view the base vectors',...
    'Callback',[...
    'cfsm_cb(305);']);

%Controlling the plot of 3D
check_3D=uicontrol(fig,...
    'Style','push','units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.785 0.445 0.07 0.07],...
    'String','3D',...
    'FontName','Arial','FontSize',12,...
    'FontWeight','Bold',...
    'Tooltip','Click to plot the 3D shape (check solid 3D if solid 3D desired)',...
    'Callback',[...
    'cfsm_cb(100);']);
checkpatch=uicontrol(fig,...
    'Style','checkbox','units','normalized',...
    'Position',[0.86 0.445 0.10 0.07],...
    'String','solid 3D',...
    'FontName','Arial','FontSize',12,...
    'Value',0,...
    'Callback',[...
    'cfsm_cb(100);']);

%Controlling the scale of the plots
scale_title=uicontrol(fig,...
    'Style','text','units','normalized',...
    'Position',[0.85 0.01 0.04 0.04],...
    'String','Scale');
scale_tex=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'Position',[0.89 0.02 0.04 0.04],...
    'String',num2str(scale),...
    'Callback',[...
    'cfsm_cb(11);']);
%
%Controlling the half-wavelength (or lengths) of interest for the plots
len_title1=uicontrol(fig,...
    'Style','text','units','normalized',...
    'FontName','Arial','FontSize',10,...
    'Position',[0.02 0.04 0.16 0.03],...
    'String','length');
len_cur=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'Position',[0.05 0.01 0.1 0.03],...
    'String',num2str(lengths(lengthindex)),...
    'Callback',[...
		'cfsm_cb(12);']);%
uplength=uicontrol(fig,...
	'Style','push','units','normalized',...
    'Position',[0.15 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ae')),...
	'Callback',[...
		'cfsm_cb(2);']);
downlength=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.01 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ac')),...
	'Callback',[...
		'cfsm_cb(3);']);

%Controlling the mode number (base vector number) of interest
mode_title1=uicontrol(fig,...
	'Style','text','units','normalized',...
   'FontName','Arial','FontSize',10,...
   'Position',[0.25 0.04 0.1 0.03],...
	'String','mode');
mode_cur=uicontrol(fig,...
	'Style','text','units','normalized',...
   'Position',[0.25 0.01 0.1 0.03],...
	'String',modename{modeindex});
upmode=uicontrol(fig,...
	'Style','push','units','normalized',...
   'Position',[0.35 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ae')),...
	'Callback',[...
		'cfsm_cb(4);']);
downmode=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.21 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ac')),...
	'Callback',[...
		'cfsm_cb(5);']);

%Move around from space to space
space_title1=uicontrol(fig,...
	'Style','text','units','normalized',...
   'FontName','Arial','FontSize',10,...
   'Position',[0.45 0.04 0.1 0.03],...
	'String','space');
space_cur=uicontrol(fig,...
	'Style','text','units','normalized',...
    'Position',[0.45 0.01 0.1 0.03],...
    'String',spacename{spaceindex});
upspace=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.55 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ae')),...
    'Callback',[...
    'cfsm_cb(6);']);
downspace=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.41 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ac')),...
    'Callback',[...
    'cfsm_cb(7);']);
%Move around from longitudinal term to longitudinal term for uncoupled basis
%For coupled basis, inside each longitudinal term losses the real meaning 
%beacuse there is coupling between longitudinal terms 
longterm_title1=uicontrol(fig,...
    'Style','text','units','normalized',...
    'FontName','Arial','FontSize',10,...
    'Position',[0.65 0.04 0.15 0.03],...
    'String','longitudinal term');
longterm_cur=uicontrol(fig,...
    'Style','text','units','normalized',...
    'Position',[0.65 0.01 0.15 0.03],...
    'String',num2str(m_a(longitermindex)));
uplongterm=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.80 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ae')),...
    'Callback',[...
    'cfsm_cb(8);']);
downlongterm=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.61 0.02 0.04 0.04],...
    'fontname','symbol',...
    'String',setstr(hex2dec('ac')),...
    'Callback',[...
    'cfsm_cb(9);']);

%Controlling the cut surface position along the lengths for 2D out-of-plan and in-plane view
cutface_title=uicontrol(fig,...
    'Style','text','units','normalized',...
    'Position',[0.35 0.445 0.25 0.03],...
    'FontName','Arial','FontSize',12,...    'ForegroundColor','r',...
    'HorizontalAlignment','right',...
    'String','Cross section position y/L (2D): ');
cutface_edit=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'Position',[0.6 0.445 0.05 0.03],...'ForegroundColor','r',...    
    'String',num2str(1/2),...
    'Callback',[...
    'cfsm_cb(10);']);

%Plot titles with updated length and mode information
outofplane_title=uicontrol(fig,...
   'Style','text','units','normalized',...
   'HorizontalAlignment','Center',...
   'FontName','Arial','FontSize',10,...
	'Position',[0.10 0.41 0.15 0.03],...
	'String','Out of plane');
inplane_title2=uicontrol(fig,...
   'Style','text','units','normalized',...
   'HorizontalAlignment','Center',...
   'FontName','Arial','FontSize',10,...
	'Position',[0.43 0.41 0.15 0.03],...
	'String','In plane');
title2_3D=uicontrol(fig,...
   'Style','text','units','normalized',...
   'HorizontalAlignment','Center',...
   'FontName','Arial','FontSize',10,...
	'Position',[0.79 0.41 0.06 0.03],...
	'String','3D shape');
%--------------------------------------------------------------------
%help
btn_gbthelp=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.7 0.905 0.04 0.04],...
    'String','?',...
    'Callback',[...
    'web(''cufsmhelp.html#20'');']);
btn_basishelp=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.25 0.855 0.04 0.04],...
    'String','?',...
    'Callback',[...
    'web(''cufsmhelp.html#70'');']);
btn_vectorhelp=uicontrol(fig,...
    'Style','push','units','normalized',...
    'Position',[0.25 0.705 0.04 0.04],...
    'String','?',...
    'Callback',[...
    'web(''cufsmhelp.html#71'');']);




