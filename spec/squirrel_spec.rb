require_relative "../squirrel"

describe Squirrel do
  let(:mascot) { Squirrel.new() }

  it "is ground-type" do
    expect(mascot.type).to eq :ground
  end

  describe "base stats" do
    it "has a base hit point value" do
      expect(mascot.base_hit_point_value).to eq 50
    end

    it "has a base attack strength" do
      expect(mascot.base_attack_strength).to eq 50
    end

    it "has a base defense strength" do
      expect(mascot.base_defense_strength).to eq 95
    end
  end

  describe "experience and levling up" do
    it "initializes with zero experience" do
      expect(mascot.experience).to eq 0
    end

    it "initializes at level 0" do
      expect(mascot.level).to eq 0
    end

    it "gains experience" do
      expect { mascot.gain_experience(50) }.to change { mascot.experience }.by(50)
    end

    it "increases its level by gaining experience" do
      expect { mascot.gain_experience(1000) }.to change { mascot.level }.by_at_least(1)
    end

    it "calculates its level as the cube root of its experience points as a whole number" do
      mascot.gain_experience(9)
      expect(mascot.level).to eq 2
    end
  end

  describe "attacking and defending" do
    it "has an attack strength" do
      expect(mascot.attack_strength).to be_a Numeric
    end

    it "gains attack strength as it levels up" do
      expect { mascot.gain_experience(1000) }.to change { mascot.attack_strength }.by_at_least(1)
    end

    it "has a defense strength" do
      expect(mascot.defense_strength).to be_a Numeric
    end

    it "gains defense strength as it levels up" do
      expect { mascot.gain_experience(1000) }.to change { mascot.defense_strength }.by_at_least(1)
    end

    it "is resistant to ground type attacks" do
      expect(mascot.resistant_to?(:ground)).to be true
    end

    it "is not resistant to other types of attacks" do
      expect(mascot.resistant_to?(:water)).to be false
    end

    it "is susceptible to flying type attacks" do
      expect(mascot.susceptible_to?(:flying)).to be true
    end

    it "is not susceptible to other types of attacks" do
      expect(mascot.susceptible_to?(:water)).to be false
    end

    it "is immune to water type attacks" do
      expect(mascot.immune_to?(:water)).to be true
    end

    it "is not immune to other types of attacks" do
      expect(mascot.immune_to?(:flying)).to be false
    end

    describe "attacks" do
      it "knows attacks" do
        expect(mascot.attacks).to match_array [:sand_attack, :earthquake, :tail_whip, :thrash]
      end

      it "reports when an attack is known" do
        expect(mascot.knows_attack?(:tail_whip)).to be true
      end

      it "reports when an attack is unknown" do
        expect(mascot.knows_attack?(:punch)).to be false
      end
    end
  end

  describe "health" do
    it "initializes with hit points" do
      expect(mascot.hit_points).to be_a Numeric
    end

    it "has a health value" do
      expect(mascot.health).to be_a Numeric
    end

    it "initializes at full health" do
      expect(mascot.full_health?).to be true
    end

    it "receives damage" do
      expect { mascot.receive_damage(5) }.to change { mascot.health }.by(-5)
    end

    it "never has less than zero health" do
      expect { mascot.receive_damage(100_000_000) }.to change { mascot.health }.to(0)
    end

    it "faints at zero health" do
      expect { mascot.receive_damage(mascot.health) }.to change { mascot.fainted? }.to(true)
    end

    it "increases in health" do
      mascot.receive_damage(5)
      expect { mascot.increase_health(1) }.to change { mascot.health }.by(1)
    end

    it "never has more health than hit points" do
      mascot.increase_health(mascot.hit_points + 100)
      expect(mascot.health).to eq mascot.hit_points
    end

    it "revives from being fainted when health increases" do
      mascot.receive_damage(mascot.health)
      expect { mascot.increase_health(1) }.to change { mascot.fainted? }.from(true).to(false)
    end

    it "recovers to full health" do
      mascot.receive_damage(5)
      expect { mascot.recover }.to change { mascot.full_health? }.from(false).to(true)
    end

    it "gains more hit points as it levels up" do
      expect { mascot.gain_experience(1000) }.to change { mascot.hit_points }.by_at_least(1)
    end
  end
end
