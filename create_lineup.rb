#!/bin/ruby


#player_names = %w(Noah Tyler Pete Andrew Joseph Liam Nathaniel Michael Dylan Benjamin Tyson Jordan Riley)
player_name =  %w(Noah Tyler Pete Andrew Joseph Liam Michael Dylan Benjamin Tyson Jordan Riley)

class Player

  attr_reader :inning_positions
  attr_reader :name

  def initialize(name)
    @name = name
    @inning_positions = []
  end

  def assign_position(available_positions)
    available_positions.each_with_index do |position, index|
      unless @inning_positions.include?(position) || skip_prime_position?(position)
        @inning_positions << available_positions.delete_at(index)
        return
      end
    end
    raise "Unable to assign position for #{name}"
  end

  def skip_prime_position? position
    prime_positions.include?(position) && [@inning_positions, prime_positions].inject(:&).any?
  end


end

players = player_names.map{|name| Player.new(name) }


def ranked_positions
  %w(P 1B 3B SS 2B LF CF RF ShortCenter LeftCenter RightCenter Backup2B BackupSS BackupCF)
end

def prime_positions
  ranked_positions[0,4]
end

[1,2,3].each do |inning_number|

  available_positions = ranked_positions
  players.shuffle.each do |player|
    player.assign_position(available_positions)
  end

end

puts "Name, 1st Inning, 2nd Inning, 3rd Inning"
players.shuffle.each do |player|

  puts "#{player.name},#{player.inning_positions.join(",")}"

end
