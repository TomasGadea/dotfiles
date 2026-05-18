return {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {
        surrounds = {
            ['~'] = {
                add = { '~~', '~~' },
                find = '~~.-~~',
                delete = '^(~~)().-(~~)()$',
            },
        },
    },
}
