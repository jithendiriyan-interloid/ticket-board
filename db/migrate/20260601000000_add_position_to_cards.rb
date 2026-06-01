class AddPositionToCards < ActiveRecord::Migration[8.1]
  def up
    add_column :cards, :position, :integer

    execute <<~SQL.squish
      UPDATE cards
      SET position = ranked.position
      FROM (
        SELECT id, ROW_NUMBER() OVER (
          PARTITION BY board_id, status_id
          ORDER BY created_at, id
        ) AS position
        FROM cards
      ) ranked
      WHERE cards.id = ranked.id
    SQL

    change_column_null :cards, :position, false
    add_index :cards, [ :board_id, :status_id, :position ]
  end

  def down
    remove_index :cards, [ :board_id, :status_id, :position ]
    remove_column :cards, :position
  end
end
