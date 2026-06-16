// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

// DOMContentLoaded ではなく turbo:load を使う
document.addEventListener('turbo:load', () => {
  const categoryItems = document.querySelectorAll('.category-item');
  const selectedCategoryInput = document.getElementById('selected-category-id');

  categoryItems.forEach(item => {
    item.addEventListener('click', () => {
      // アクティブなカテゴリのスタイルを変更
      categoryItems.forEach(i => i.classList.remove('active'));
      item.classList.add('active');

      // 選択されたカテゴリIDを取得
      const categoryId = item.dataset.categoryId;
      
      // フォームの hidden フィールドに選択されたカテゴリIDを設定
      if (selectedCategoryInput) {
        selectedCategoryInput.value = categoryId;
      }

      // メモ一覧をフィルタリング
      const memoItems = document.querySelectorAll('.memo-item');
      
      memoItems.forEach(memo => {
        const memoCategoryId = memo.dataset.categoryId;
        
        if (memoCategoryId === categoryId) {
          memo.style.display = 'block'; // 該当カテゴリのメモを表示
        } else {
          memo.style.display = 'none'; // 他のカテゴリのメモを非表示
        }
      });
    });
  });
});