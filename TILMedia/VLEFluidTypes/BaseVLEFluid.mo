﻿within TILMedia.VLEFluidTypes;
record BaseVLEFluid "Base record for VLEFluid definitions"
  extends TILMedia.Internals.ClassTypes.Record;
  constant Boolean fixedMixingRatio
    "Treat medium as pseudo pure in Modelica if it is a mixture"
    annotation(Dialog, HideResult = true);
  constant Integer nc_propertyCalculation(min=1)
    "Number of components for fluid property calculations"
    annotation(Dialog, HideResult = true);
  final constant Integer nc=if fixedMixingRatio then 1 else nc_propertyCalculation
    "Number of components in Modelica models"
    annotation(Evaluate=true, HideResult = true);
  parameter TILMedia.Internals.VLEFluidName[:] vleFluidNames = {""}
    "Array of VLEFluid names e.g. {\"vleFluidName\"} for pure component"
    annotation(Dialog, choices);
  parameter Real[nc_propertyCalculation] mixingRatio_propertyCalculation = {1}
    "Mixing ratio for fluid property calculation (={1} for pure components)"
    annotation(Dialog, HideResult = true);
  final parameter Real[nc] defaultMixingRatio = if fixedMixingRatio then {1} else mixingRatio_propertyCalculation
    "Default composition for models in Modelica (={1} for pure components)"
    annotation(HideResult = true);
  final parameter Real xi_default[nc-1] = defaultMixingRatio[1:end-1]/sum(defaultMixingRatio)
    "Default mass fractions"
    annotation(HideResult = true);
  final parameter String concatVLEFluidName=TILMedia.Internals.concatNames(vleFluidNames)
    annotation(Dialog(tab="Internals"));
  constant Integer ID=0
    "ID is used to map the selected VLEFluid to the sim.cumulatedVLEFluidMass array item" annotation(HideResult = true);
  annotation (Documentation(info="<html>
<p><br>Every VLEFluid substance model contains a substance record as replaceable parameter extending from this base VLEFluid model. The substance record contains the following parameters: </p>
<ul>
<li>fixedMixingRatio - Boolean = true, if mixing ratio is fixed during simulation. </li>
<li>nc_propertyCalculation - Integer with number of components which are calculated. </li>
<li>\"substanceNames\" - VLEFluidName 1, VLEFluidName 2, and so on. Array which lists the substance names. </li>
<li>mixingRatio_propertyCalculation - Array with the mixing ratio of all substances. </li>
</ul>
<p><b>Access additional substances:</b> </p>
<p>To acces the properties of an additional substance, it is possible to create a new substance reccord. For more information on the acces of additional propeties see the <a href=\"modelica://TILMedia.UsersGuide.SubstanceRecord\">substance record documentation</a>. </p>
<p>Furthermore it is possible to parameterize this VLEFluide base record, using a VLEFluid substance name, listed in the <a href=\"modelica://TILMedia.UsersGuide.SubstanceNames\">substance names documentation</a>. An example how to parameterize the base VLEFluid model is shown below. However note that this is only a local configuration and therefore only accesible in the corresponding model.</p>
<p><img src=\"modelica://TILMedia/Resources/Images/Base_VLE_Parameter_frame.PNG\"> </p>
</html>"));
end BaseVLEFluid;
