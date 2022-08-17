# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      site: 'うつメイト',
      title: 'うつメイト',
      reverse: true,
      charset: 'utf-8',
      description: '「記録を残して、うつ病治療に役立てよう」 うつメイトは、簡単な質問に答えるだけで、うつ病治療に役立つレポートが作成できるサービスです。',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: :title,
        type: 'website',
        site_name: 'うつメイト',
        description: :description,
        image: image_url('tori_hello.png'),
        url: ''
      },
      twitter: {
        title: :title,
        card: 'summary_large_image',
        site: '@nekokitare',
        description: :description,
        image: image_url('tori_hello'),
        domain: ''
      }
    }
  end
end
