require.config({
    paths: {
        jquery: 'jquery',
    },
    shim: {
        jquery: {
            exports: 'jquery'
        },
        bootstrap: {
            deps: ['jquery']
        }
    }
});

requirejs(['jquery','bootstrap','mustache','app','picker','demo','call','row','cs-page']);
