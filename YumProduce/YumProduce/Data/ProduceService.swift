//
//  ProduceService.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import Foundation

class ProduceService {
    
    func getProduce() -> [Produce] {
        return [
            Produce(named: "Peas", description: "Refrigerate in a perforated plastic bag for 3-5 days. Shell peas immediately before using."),
            Produce(named: "Zucchini", description: "Store zucchini in a plastic bag in the refrigerator for 4 to 5 days. Do not wash it until you are ready to use."),
            Produce(named: "Artichoke", description: "slice a dime width off the artichoke stem, sprinkle with water and refrigerate in an airtight plastic bag. It’s best to cook them within five to seven days after purchase. "),
            Produce(named: "Cucumber", description: "Refrigerate in plastic bag up to 1 week"),
            Produce(named: "Cauliflower", description: "Refrigerate in plastic bag up to 5 days"),
            Produce(named: "Beet", description: "Store roots in a plastic bag in refrigerator for up to 3 weeks. Wash before cooking"),
            Produce(named: "Asparagus", description: "Refrigerate for up to four days by wrapping ends of stalks in wet paper towel and placing in plastic bag"),
            Produce(named: "Onion", description: "Store whole in a cool, dark, well ventilated place for use within 4 weeks-— away from potatoes, apples, celery, and pears. Refrigerate cut onions in a tightly sealed container, use within 2-3 days."),
            Produce(named: "Tomato", description: "Store at room temperature away from direct sunlight."),
            Produce(named: "Fava Beans", description: "place them in a plastic bag in the crisper section of the refrigerator right away. Use within 5-7 days in the refrigerator."),
            Produce(named: "Shallots", description: "Store whole in a cool, dark, well-ventilated place for use within 4 weeks. Refrigerate cut shallots in a tightly sealed container for use within 2-3 days."),
            Produce(named: "Radish", description: "Refrigerate in plastic bag for use within 1 week. Remove tops before storing."),
            Produce(named: "Butternut Squash", description: "Store in a cool, dark place for up to a month. Once cut, refrigerate unused portion."),
            Produce(named: "Carrot", description: "Refrigerate in plastic bag with tops removed up to 2 weeks."),
            Produce(named: "Celery", description: "Refrigerate in a plastic bag for a week or more.")
        ]
    }
}
