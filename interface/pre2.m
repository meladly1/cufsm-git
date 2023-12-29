function pre2
%BWS
%October 2001 
%Z. Li, 7/20/2010
%Preprocessor screen for finite strip analysis
%
%general
global fig screen prop node elem lengths curve shapes clas springs constraints GBTcon BC m_all neigs version screen zoombtn panbtn rotatebtn
%output from pre2
global subfig ed_prop ed_node ed_elem ed_lengths axestop screen flags modeflag ed_springs ed_constraints popanelpre
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
%
%fig.Visible='off'
%pause(2)
clf
%fig.Visible='off'
name=['CUFSM v',version,' -- Finite Strip Pre-Processor -- General Input'];
set(fig,'Name',name);
%
%------------------------------------------------------------------------------------
screen=2;
commandbar;
%
%
%
%initial values
%---------------
if ~isempty(prop)&~isempty(node)&~isempty(elem)
    iprop=prop;
    inode=node;
    ielem=elem;
    if ~isempty(springs)
        isprings=springs;
    else
        isprings=0;
    end
    if ~isempty(constraints)
        iconstraints=constraints;
    else
        iconstraints=0;
    end
    if ~isempty(GBTcon)
        modeflag=[0 0 0 0];
        iglobal=GBTcon.glob;
        idist=GBTcon.dist;
        ilocal=GBTcon.local;
        iother=GBTcon.other;
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
        if ~isempty(GBTcon.ospace)
            iospace=GBTcon.ospace;
        else
            iospace=1;
        end
        if ~isempty(GBTcon.orth)
            iorth=GBTcon.orth;
        else
            iorth=2;
        end
        if ~isempty(GBTcon.couple)
            icouple=GBTcon.couple;
        else
            icouple=1;
        end        
    else
        modeflag=[0 0 0 0];
        iglobal=0;
        idist=0;
        ilocal=0;
        iother=0;
        GBTcon.glob=iglobal;
        GBTcon.dist=idist;
        GBTcon.local=ilocal;
        GBTcon.other=iother;
    end
    
    if exist('flags')<1|isempty(flags)
    %flags:[node# element# mat# stress# stresspic coord constraints springs origin propaxis] 1 means show
    flags=[1 0 0 0 0 0 1 1 1 0]; %see crosssect for the use of the different plotting flags
    end
    
else
    %Default Initial Values for the editable areas
    iprop=[100 29500 29500 0.3 0.3 29500/(2*(1+0.3))];
    inode=[1 5 1 1 1 1 1 -50*3.5/4.5
        2 5 0 1 1 1 1 -50
        3 2.5 0 1 1 1 1 -50
        4 0 0 1 1 1 1 -50
        5 0 3 1 1 1 1 -50*1.5/4.5
        6 0 6 1 1 1 1 50*1.5/4.5
        7 0 9 1 1 1 1 50
        8 2.5 9 1 1 1 1 50
        9 5 9 1 1 1 1 50
        10 5 8 1 1 1 1 50*3.5/4.5];
    ielem=[1 1 2 0.1 100
        2 2 3 0.1 100
        3 3 4 0.1 100
        4 4 5 0.1 100
        5 5 6 0.1 100
        6 6 7 0.1 100
        7 7 8 0.1 100
        8 8 9 0.1 100
        9 9 10 0.1 100];
    isprings=0;
    iconstraints=0;
    prop=iprop;
    node=inode;
    elem=ielem;
    springs=isprings;
    constraints=iconstraints;
    %%%%%%%
    modeflag=[0 0 0 0];
    iglobal=0;
    idist=0;
    ilocal=0;
    iother=0;
    iospace=1;
    icouple=1;
    iorth=2;
    GBTcon.glob=iglobal;
    GBTcon.dist=idist;
    GBTcon.local=ilocal;
    GBTcon.other=iother;
    GBTcon.ospace=iospace;
    GBTcon.couple=icouple;
    GBTcon.orth=iorth;
    %flags:[node# element# mat# stress# stresspic coord constraints springs origin propaxis] 1 means show
    flags=[1 0 0 0 0 0 1 1 1 0]; %see crosssect for the use of the different plotting flags
end
%
%
%DEFINE THE AXIS THAT WILL BE USED FOR THE TWO PLOTS
axestop=axes('Units','normalized','Position',[0.28 0.20 0.71 0.73],'visible','off');
%axesbot=axes('Units','normalized','Position',[0.5 0.11 0.48 0.36],'visible','off');
%-----------------------------------------------------------------
%
%Command Buttons
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.27-0.1 0.0 0.1 0.41]);
title_modify=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...'fontweight','b',...
    'FontName','Arial','FontSize',14,...    
    'Position',[0.19 0.31 0.05 0.04],...
    'String','Modify');
% %C/Z template now part of main menu, removed from pre interface Feb 2016
    % template=uicontrol(fig,...
    % 	'Style','push','units','normalized',...
    % 	'Position',[0.275 0.44 0.09 0.04],...
    % 	'String','C/Z Template',...
    %     'Tooltip','Select to use template to enter dimensions for common Cee or Zed members',...
    % 	'Callback',[...
    % 		'pre2_cb(1);']);
    %		'[prop,node,elem,lengths,springs,constraints,h_tex,b1_tex,d1_tex,q1_tex,b2_tex,d2_tex,q2_tex,r1_tex,r2_tex,r3_tex,r4_tex,t_tex,C,Z,kipin,Nmm,axestemp,subfig]=template(fig);,']);%,...
doubler=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.39-0.15 0.09 0.04],...
	'String','Double Elem.',...
    'Tooltip','Double all elements',...
	'Callback',[...
		'pre2_cb(2);']);
double_one=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.35-0.15 0.09 0.04],...
	'String','Divide Elem.',...
    'Tooltip','Divide selected element at x/L',...
	'Callback',[...
		'pre2_cb(101);']);
combine_one=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.31-0.15 0.09 0.04],...
	'String','Delete Elem.',...
    'Tooltip','Delete one interior node',...
	'Callback',[...
		'pre2_cb(102);']);
translate_some=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.27-0.15 0.09 0.04],...
	'String','Trans. Node',...
    'Tooltip','Translate one or many nodes',...
	'Callback',[...
		'pre2_cb(103);']);
move_rot_model_some=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.23-0.15 0.09 0.04],...
	'String','Move/Rot Model',...
    'Tooltip','Translate or rotate the entire model',...
	'Callback',[...
		'pre2_cb(104);']);
dup_section=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.275-0.1 0.19-0.15 0.09 0.04],...
	'String','Duplicate',...
    'Tooltip','Duplicate model, i.e. for built-up section',...
	'Callback',[...
		'pre2_cb(105);']);
%
%

%Update, Plotting and Plot Options
%Prior to Feb 2016 we had an update plot button for manually updating the
%plot, but that has been made automatic and is no longer needed so is
%commented out in Feb 2016
        % box=uicontrol(fig,...
        %    'Style','frame','units','normalized',...
        %    'Position',[0.27 0.490 0.1 0.45]);
        % plot=uicontrol(fig,...
        % 	'Style','push','units','normalized',...
        % 	'Position',[0.275 0.795 0.09 0.05],...
        % 	'String','Update Plot',...
        %     'Tooltip','Update the plot left whenever cross section, springs, or constraints changed',...
        % 	'Callback',[...
        % 		'pre2_cb(3);']);
        % title_prop=uicontrol(fig,...
        % 	'Style','text','units','normalized',...
        % 	'HorizontalAlignment','Left',...
        %    'Position',[0.28 0.765 0.08 0.03],...
        %    'String','Plot Options:');
%----------------------------------------------------

%plot options
%Update, Plotting and Plot Options
popanelpre=uipanel(fig,...
   'units','normalized',...
   'visible','off',...
   'Position',[0.9 0.965-(0.665-0.390) 0.1 0.665-0.390]);
plotoptions=uicontrol(fig,...
	'Style','push','units','normalized',...
	'HorizontalAlignment','Center',...
   'Position',[0.91 0.965 0.08 0.03],...
   'String','Plot Options:',...
   'Callback',[...
 		'pre2_cb(20);']);
%All the various plotting options
%flags:[node# element# mat# stress# stresspic coord constraints springs origin propaxis] 1 means show
togglenode=uicontrol('Parent',popanelpre,...
  'Style','checkbox','units','normalized',...
  'Position',[0.01 0.91 0.8 0.08],...
  'String','node #',...
  'Value',flags(1),...
  'Callback',[...
		'pre2_cb(4);']);
  %'Position',[0.01 0.635 0.08 0.03],...
toggleelem=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.81 0.8 0.08],...
   'String','element #',...
   'Value',flags(2),...
   'Callback',[...
 		'pre2_cb(5);']);
togglemat=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.71 0.8 0.08],...
   'String','material #',...
   'Value',flags(3),...
   'Callback',[...
 		'pre2_cb(6);']);
togglestress=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.61 0.8 0.08],...
   'String','stress mag.',...
   'Value',flags(4),...
   'Callback',[...
 		'pre2_cb(7);']);
togglestresspic=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.51 0.8 0.08],...
   'String','stress dist.',...
   'Value',flags(5),...
   'Callback',[...
 		'pre2_cb(8);']);
togglecoord=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.41 0.8 0.08],...
   'String','coordinates',...
   'Value',flags(6),...
   'Callback',[...
 		'pre2_cb(9);']);
toggleconstraints=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.31 0.8 0.08],...
   'String','constraints',...
   'Value',flags(7),...
   'Callback',[...
 		'pre2_cb(10);']);
togglesprings=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.21 0.8 0.08],...
   'String','springs',...
   'Value',flags(8),...
   'Callback',[...
 		'pre2_cb(11);']);
toggleorigin=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.11 0.8 0.08],...
   'String','origin',...
   'Value',flags(9),...
   'Callback',[...
 		'pre2_cb(12);']);
togglepropaxis=uicontrol('Parent',popanelpre,...
   'Style','checkbox','units','normalized',...
   'Position',[0.01 0.01 0.8 0.08],...
   'String','centroidal axes',...
   'Value',flags(10),...
   'Callback',[...
 		'pre2_cb(13);']);    
%------------------------------------------------



%--------------------------------------------------------------------
%Material Properties
%Static text
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.0 0.8 0.27 0.20]);
title_prop=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...'fontweight','b',...
    'FontName','Arial','FontSize',14,...
   'Position',[0.01 0.94 0.25 0.04],...
   'String','Material Properties');
txt_prop=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...
    'FontName','Arial','FontSize',10,...
   'Position',[0.01 0.90 0.25 0.03],...
   'String','mat# | Ex | Ey | vx | vy | Gxy');
ed_prop=uicontrol(fig,...
    'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.01 0.82 0.25 0.08],...
    'String',num2str(iprop),...
    'Max',100,...
    'Callback',[...
    'pre2_cb(3);']);
% ed_prop=uitable(fig,...
%     'units','normalized',...
%     'Position',[0.01 0.77 0.35 0.08],...
%     'ColumnName',{'mat#','Ex','Ey','vx','vy','Gxy'},...
%     'RowName',{},...
%     'Data',[iprop;zeros(100,6)]);%,...
%     %'Callback',[...
%     %'pre2_cb(3);'])
% %    'ColumnWidth',{50},...   
% %ed_prop.Position(3) = ed_prop.Extent(3);
% %ed_prop.Position(4) = ed_prop.Extent(4);

%
%--------------------------------------------------------------------
%Nodal Properties-
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.0 0.37 0.27 0.43]);
title_node=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...
    'FontName','Arial','FontSize',14,...
   'Position',[0.01 0.74 0.25 0.04],...
   'String','Nodes');
txt_node=uicontrol(fig,...
	'Style','text','units','normalized',...
	'Position',[0.01 0.70 0.25 0.03],...
    'FontName','Arial','FontSize',10,...
	'HorizontalAlignment','Left',...
	'String','node# | x | z | xdof | zdof | ydof | qdof | stress');
ed_node=uicontrol(fig,...
	'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
	'String',num2str(inode),...
	'Position',[0.01 0.39 0.25 0.31],...
	'Max',1000,...%);
    'Callback',[...
 		'pre2_cb(3);']);
% set(ed_node,'String',sprintf('%i %.4f %.4f %i %i %i %i %.3f\n',node'));
%--------------------------------------------------------------------
%Element Connectivity
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.0 0.0 0.27-0.1 0.37]);
title_elem=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...'fontweight','b',...
    'FontName','Arial','FontSize',14,...    
    'Position',[0.01 0.31 0.25-0.1 0.04],...
    'String','Elements');
txt_elem=uicontrol(fig,...
	'Style','text','units','normalized',...
	'Position',[0.01 0.27 0.25-0.1 0.03],...
    'FontName','Arial','FontSize',10,...
	'HorizontalAlignment','Left',...
	'String','elem# | nodei | nodej | thickness | mat#');
ed_elem=uicontrol(fig,...
	'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
   	'String',num2str(ielem),...
	'Position',[0.01 0.02 0.25-0.1 0.25],...
	'Max',1000,...%);
    'Callback',[...
 		'pre2_cb(3);']);
%------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------

%Section Properties and Applied Load used to be buttons on the pre page,
%but have moved to the main interface and are now commented out BWS
%February 2016
        % %Properties Button
        % box=uicontrol(fig,...
        %    'Style','frame','units','normalized',...
        %    'Position',[0.27 0.85 0.1 0.1]);
        % pushproperties=uicontrol(fig,...
        %     'Style','push','units','normalized',...
        %     'Position',[0.275 0.90 0.09 0.047],...
        %     'String','Sect. Prop.',...
        %     'Tooltip','Select to view the properties of the cross section and/or export to MASTAN',...
        %     'Callback',[...
        %     'pre2_cb(203);']);
        % %Load Button
        % pushloading=uicontrol(fig,...
        % 	'Style','push','units','normalized',...
        % 	'Position',[0.275 0.853 0.09 0.047],...
        %     'String','Applied Load',...
        %     'Tooltip','Select to generate the applied stress including from a MASTAN model',...
        % 	'Callback',[...
        % 		'pre2_cb(202);']);
    % stringtxt1=uicontrol(fig,...
    %     'Style','text','units','normalized',...
    %     'HorizontalAlignment','center',...
    %     'FontName','Arial','FontSize',10,...
    %     'Position',[0.38 0.90 0.08 0.03],...
    %     'String','Sectional','fontweight','b',...
    %     'enable','inactive');
    % stringtxt2=uicontrol(fig,...
    %     'Style','text','units','normalized',...
    %     'HorizontalAlignment','center',...
    %     'FontName','Arial','FontSize',10,...
    %     'Position',[0.38 0.87 0.08 0.03],...
    %     'String','Properties','fontweight','b',...
    %     'enable','inactive');
%--------------------------------------------------------------------
%Springs
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.27 0.0 0.36 0.18]);
title_spring=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left','TooltipString','Enter discrete or foundation springs infromation here',...
    'FontName','Arial','FontSize',14,...
   'Position',[0.28 0.14 0.34 0.03],...
   'String','Springs');
txt_springs=uicontrol(fig,...
	'Style','text','units','normalized',...
	'Position',[0.28 0.11 0.34 0.03],...
	'HorizontalAlignment','Left',...
	'String','spring# | nodei | nodej | ku | kv | kw | kq | local | discrete | y/L');
%	'String','node# | DOF(x=1,z=2,y=3,theta=4) | kspring | kflag');
ed_springs=uicontrol(fig,...
	'Style','edit','units','normalized','TooltipString','Note springs under active development',......
    'HorizontalAlignment','Left',...
	'String',num2str(isprings),...
	'Position',[0.28 0.02 0.34 0.09],...
	'Max',1000,...%);
    'Callback',[...
 		'pre2_cb(3);']);    
%--------------------------------------------------------------------
%Constraints
box=uicontrol(fig,...
   'Style','frame','units','normalized',...
   'Position',[0.63 0.0 0.37 0.18]);
title_con=uicontrol(fig,...
	'Style','text','units','normalized',...
	'HorizontalAlignment','Left',...
    'FontName','Arial','FontSize',14,...
   'Position',[0.64 0.14 0.34 0.03],...
   'String','General Constraints');
txt_constraints=uicontrol(fig,...
	'Style','text','units','normalized',...
	'Position',[0.64 0.11 0.34 0.03],...
	'HorizontalAlignment','Left',...
	'String','node#e | DOFe | coeff. | node#k | DOFk');
ed_constraints=uicontrol(fig,...
	'Style','edit','units','normalized',...
    'HorizontalAlignment','Left',...
	'String',num2str(iconstraints),...
	'Position',[0.64 0.02 0.34 0.09],...
	'Max',1000,...%);
    'Callback',[...
 		'pre2_cb(3);']);
master_slave=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.83 0.14 0.08 0.03],...
	'String','Master-Slave',...
    'Tooltip','Make slave nodes to a master node',...
	'Callback',[...
		'pre2_cb(201);']);
%------------------------------------------------------------------
btn_prophelp=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.22 0.9 0.04 0.04],...
	'String','?',...
   'Callback',[...
      'cufsmhelp(3);']);
btn_nodehelp=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.22 0.7 0.04 0.04],...
	'String','?',...
   'Callback',[...
      'cufsmhelp(4);']);
btn_elemhelp=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.22-0.1 0.32 0.04 0.04],...
	'String','?',...
   'Callback',[...
      'cufsmhelp(5);']);
btn_springhelp=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.49 0.14 0.03 0.03],...
	'String','?',...
   'Callback',[...
      'cufsmhelp(16);']);
btn_conhelp=uicontrol(fig,...
	'Style','push','units','normalized',...
	'Position',[0.91 0.14 0.03 0.03],...
	'String','?',...
   'Callback',[...
      'cufsmhelp(19);']);
%
%Initial Plots
set(ed_prop,'String',sprintf('%i %.2f %.2f %.2f %.2f %.2f\n',iprop'));
set(ed_node,'String',sprintf('%i %.4f %.4f %i %i %i %i %.3f\n',node'));
set(ed_elem,'String',sprintf('%i %i %i %.6f %i\n',ielem'));
%set(ed_springs,'String',sprintf('%i %i %.6f %i\n',isprings'));
set(ed_springs,'String',sprintf('%i %i %i %.6f %.6f %.6f %.6f %i %i %.3f\n',isprings'));
set(ed_constraints,'String',sprintf('%i %i %.3f %i %i %.3f %i %i\n',iconstraints'));
crossect(node,elem,axestop,springs,constraints,flags);
%
%