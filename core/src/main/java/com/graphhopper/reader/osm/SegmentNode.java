/*
 *  Licensed to GraphHopper GmbH under one or more contributor
 *  license agreements. See the NOTICE file distributed with this work for
 *  additional information regarding copyright ownership.
 *
 *  GraphHopper GmbH licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except in
 *  compliance with the License. You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package com.graphhopper.reader.osm;

import java.util.Map;

class SegmentNode {
    long osmNodeId;
    int id;
    Map<String, Object> tags;

    public SegmentNode(long osmNodeId, int id, Map<String, Object> tags) {
        this.osmNodeId = osmNodeId;
        this.id = id;
        this.tags = tags;
    }

    @Override
    public String toString() {
        return "id: " + id + ", osm-node-id: " + osmNodeId;
    }
}
