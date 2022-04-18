pygui(true)




function useToroidDesignGUI()
    win = GtkWindow("Toroid Designer")
    g = GtkGrid()

    RowCnt = 1
    
    
    LTargDesc = GtkEntry()  # a widget for entering text
    set_gtk_property!(LTargDesc, :text, "Target Inductance [H]")
    makeDescBox(LTargDesc)
    LtargVal =GtkEntry()
    makeValBox(LtargVal,100e-6)
    g[1,RowCnt] = LTargDesc
    g[2,RowCnt] = LtargVal
    
    RowCnt +=1

    WireDiamDesc = GtkEntry()
    set_gtk_property!(WireDiamDesc, :text, "Wire Diameter [m]")
    makeDescBox(WireDiamDesc)
    WireDiamVal =GtkEntry()
    makeValBox(WireDiamVal,0.001)
    g[1,RowCnt] = WireDiamDesc
    g[2,RowCnt] = WireDiamVal
    RowCnt +=1


    WireFillDesc = GtkEntry()
    set_gtk_property!(WireFillDesc, :text, "Wire fill [0-1, UL]")
    makeDescBox(WireFillDesc)
    WireFillVal =GtkEntry()
    makeValBox(WireFillVal,1)
    g[1,RowCnt] = WireFillDesc
    g[2,RowCnt] = WireFillVal
RowCnt +=1

    NumLayersDesc = GtkEntry()
set_gtk_property!(NumLayersDesc, :text, "Number of layers")
makeDescBox(NumLayersDesc)
NumLayersVal =GtkEntry()
makeValBox(NumLayersVal,2)
g[1,RowCnt] = NumLayersDesc
g[2,RowCnt] = NumLayersVal
RowCnt +=1

AlphaDesc = GtkEntry()
set_gtk_property!(AlphaDesc, :text, "Aspect Ratio, α [UL]")
makeDescBox(AlphaDesc)
AlphaVal =GtkEntry()
makeValBox(AlphaVal,2)
g[1,RowCnt] = AlphaDesc
g[2,RowCnt] = AlphaVal
RowCnt +=1

Res_Box = GtkEntry()
set_gtk_property!(Res_Box, :text, " ---Results---")
makeDescBox(Res_Box)
g[1:2,RowCnt] = Res_Box
RowCnt +=1


ID_Desc = GtkEntry()
set_gtk_property!(ID_Desc, :text, "Toroid Inner Diameter [meters]")
makeDescBox(ID_Desc)
ID_Val =GtkEntry()
makeResultsBox(ID_Val,1)
g[1,RowCnt] = ID_Desc
g[2,RowCnt] = ID_Val
RowCnt +=1


OD_Desc = GtkEntry()
set_gtk_property!(OD_Desc, :text, "Toroid Outer Diameter [meters]")
makeDescBox(OD_Desc)
OD_Val =GtkEntry()
makeResultsBox(OD_Val,1)
g[1,RowCnt] = OD_Desc
g[2,RowCnt] = OD_Val
RowCnt +=1


N_Desc = GtkEntry()
set_gtk_property!(N_Desc, :text, "Turns")
makeDescBox(N_Desc)
N_Val =GtkEntry()
makeResultsBox(N_Val,1)
g[1,RowCnt] = N_Desc
g[2,RowCnt] = N_Val
RowCnt +=1


WireL_Desc = GtkEntry()
set_gtk_property!(WireL_Desc, :text, "Wire length [meters]")
makeDescBox(WireL_Desc)
WireL_Val =GtkEntry()
makeResultsBox(WireL_Val,1)
g[1,RowCnt] = WireL_Desc
g[2,RowCnt] = WireL_Val
RowCnt +=1

WireR_Desc = GtkEntry()
set_gtk_property!(WireR_Desc, :text, "Wire resistance [Ω]")
makeDescBox(WireR_Desc)
WireR_Val =GtkEntry()
makeResultsBox(WireR_Val,1)
g[1,RowCnt] = WireR_Desc
g[2,RowCnt] = WireR_Val
RowCnt +=1

CoreShapeDesc = GtkEntry()
set_gtk_property!(CoreShapeDesc, :text, "Core Shape")
makeDescBox(CoreShapeDesc)
g[1,RowCnt] = CoreShapeDesc


Shape_cb = GtkComboBoxText()
choices = ["D-Shaped", "Circular"]
for choice in choices
  push!(Shape_cb,choice)
end
g[2,RowCnt] = Shape_cb
RowCnt +=1


FlatH_Desc = GtkEntry()
set_gtk_property!(FlatH_Desc, :text, "Flat height [meters]")
makeDescBox(FlatH_Desc)
FlatH_Val =GtkEntry()
makeResultsBox(FlatH_Val,1)
g[1,RowCnt] = FlatH_Desc
g[2,RowCnt] = FlatH_Val
RowCnt +=1

MaxH_Desc = GtkEntry()
set_gtk_property!(MaxH_Desc, :text, "Max height [meters]")
makeDescBox(MaxH_Desc)
MaxH_Val =GtkEntry()
makeResultsBox(MaxH_Val,1)
g[1,RowCnt] = MaxH_Desc
g[2,RowCnt] = MaxH_Val
RowCnt +=1

RadAtPeak_Desc = GtkEntry()
set_gtk_property!(RadAtPeak_Desc, :text, "Radius at peak [meters]")
makeDescBox(RadAtPeak_Desc)
RadAtPeak_Val =GtkEntry()
makeResultsBox(RadAtPeak_Val,1)
g[1,RowCnt] = RadAtPeak_Desc
g[2,RowCnt] = RadAtPeak_Val
RowCnt +=1


RunScriptButton = GtkButton()
set_gtk_property!(RunScriptButton, :label, "RUN DESIGNER")
g[1:2,RowCnt] = RunScriptButton
RowCnt +=1

set_gtk_property!(Shape_cb,:active,1)

id = signal_connect(RunScriptButton, "button-press-event") do widget, event
    # println("Starting toroid designer")

    CoilGeom =ToroidOptimizer(
        getVal(WireDiamVal),
        getVal(LtargVal);
    NumLayers = Int(getVal(NumLayersVal)),
    CoreMu = 1,
    Alpha = Int(getVal(AlphaVal)),
    CuFillFactor = getVal(WireFillVal))
    if parse(Int,get_gtk_property(Shape_cb,:active,String))==0
        set_gtk_property!(ID_Val, :text, "$(CoilGeom.DCore.ID)")
        set_gtk_property!(OD_Val, :text, "$(CoilGeom.DCore.OD)")
        set_gtk_property!(MaxH_Val, :text, "$(CoilGeom.DCore.MaxHeight)")
        set_gtk_property!(RadAtPeak_Val, :text, "$(CoilGeom.DCore.RadiusAtPeak)")
        set_gtk_property!(FlatH_Val, :text, "$(CoilGeom.DCore.FlatHeight)")
        
        set_gtk_property!(N_Val, :text, "$(CoilGeom.DCore.Turns)")
        set_gtk_property!(WireL_Val, :text, "$(CoilGeom.DCore.WireLength)")
        set_gtk_property!(WireR_Val, :text, "$(CoilGeom.DCore.Resistance)")
    else
        set_gtk_property!(ID_Val, :text, "$(CoilGeom.Circ.ID)")
        set_gtk_property!(OD_Val, :text, "$(CoilGeom.Circ.OD)")

        set_gtk_property!(RadAtPeak_Val, :text, "N/A")
        set_gtk_property!(MaxH_Val, :text, "N/A")
        set_gtk_property!(FlatH_Val, :text, "N/A")

        set_gtk_property!(N_Val, :text, "$(CoilGeom.Circ.Turns)")
        set_gtk_property!(WireL_Val, :text, "$(CoilGeom.Circ.WireLength)")
        set_gtk_property!(WireR_Val, :text, "$(CoilGeom.Circ.Resistance)")
    end

end


set_gtk_property!(g, :column_homogeneous, true)
set_gtk_property!(g, :column_spacing, 15)  # introduce a 15-pixel gap between columns
push!(win, g)
showall(win)


end

function makeResultsBox(Box,DefaultVal)
    
    set_gtk_property!(Box, :sensitive,false)
    set_gtk_property!(Box, :editable,false)
    set_gtk_property!(Box, :text, "$DefaultVal")
end


