import { defineUserConfig } from 'vuepress'
import type { DefaultThemeOptions } from 'vuepress'
import { path } from '@vuepress/utils'

export default defineUserConfig<DefaultThemeOptions>({
    lang: 'en-US',
    title: 'Alga',
    description: 'Just playing around',
    theme: '@vuepress/theme-default',
    alias: {
        '@root': path.resolve(__dirname, '/images')
    },
    locales: {
        '/': {
            lang: 'en-US',
            title: 'Alga',
            description: 'A powerful tool app for all developers.',
        },
        '/zh/': {
            lang: 'zh-CN',
            title: 'Alga',
            description: '一款强大的开发者工具集。',
        },
    },
    themeConfig: {
        locales: {
            '/': {
                navbar: [
                    { text: 'Download', link: '/download/' },
                    { text: 'Modules', link: '/modules/' },
                ],
                sidebar: {
                    '/modules/': [
                        { text: 'Converters', link: '/modules/converters.md' },
                        { text: 'Encoders Decoders', link: '/modules/encoders_decoders.md' }
                    ]
                }
            },
            '/zh': {
                navbar: [
                    { text: 'Download', link: '/zh/download/' }
                ]
            }
        }
    },
})
