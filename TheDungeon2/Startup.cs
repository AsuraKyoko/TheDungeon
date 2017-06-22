using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TheDungeon.Startup))]
namespace TheDungeon
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
