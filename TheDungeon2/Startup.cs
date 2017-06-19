using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TheDungeon2.Startup))]
namespace TheDungeon2
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
