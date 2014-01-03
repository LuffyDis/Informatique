using System;
using System.ComponentModel.Composition;
using Microsoft.Practices.Prism.MefExtensions.Modularity;
using Microsoft.Practices.Prism.Modularity;
using Microsoft.Practices.Prism.Regions;
using Microsoft.Practices.ServiceLocation;
using Pluralsight.Prism.Common;
using Pluralsight.Prism.ModuleA.Views;

namespace Pluralsight.Prism.ModuleA
{
    [ModuleExport(typeof(ModuleAModule), InitializationMode = InitializationMode.WhenAvailable)]
    public class ModuleAModule : IModule
    {
        private readonly IRegionManager _regionManager;

        public void Initialize()
        {

            _regionManager.RegisterViewWithRegion(RegionNames.MenuRegionName, typeof (ViewModuleA));

            //Dynamically 
            IRegion region = _regionManager.Regions[RegionNames.MenuRegionName];
            var ob = ServiceLocator.Current.GetInstance<ViewModuleA>();
        }

        [ImportingConstructor]
        public ModuleAModule(IRegionManager regionManager)
        {
            _regionManager   = regionManager;
        }

    }
}
