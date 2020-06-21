local configs = require 'nvim_lsp/configs'
local util = require 'nvim_lsp/util'

configs.eclipse_jdt_ls = {
    default_config = {
        cmd = {
            "java";
            "-Declipse.application=org.eclipse.jdt.ls.core.id1";
            "-Dosgi.bundles.defaultStartLevel=4";
            "-Declipse.product=org.eclipse.jdt.ls.core.product";
            "-Dlog.protocol=true";
            "-Dlog.level=ALL";
            "-noverify";
            "-Xmx1G";
            "-jar";
            "D:\\Software\\eclipse.jdt.ls\\plugins\\org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar";
            "-configuration";
            "D:\\Software\\eclipse.jdt.ls\\config_win";
            "-data";
            vim.fn.getcwd();
        };
        filetypes = { "java" };
        root_dir = util.root_pattern("pom.xml", "build.gradle", ".classpath", ".project", ".git/");
    };
}
